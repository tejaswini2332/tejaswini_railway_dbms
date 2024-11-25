import subprocess as sp
import pymysql
import pymysql.cursors
from tabulate import tabulate


############# INSERTS #############

# INSERT EMPLOYEE
def hireEmp():
    try:
        row = {}
        print("Enter new employee's details: ")
        name = (input("Name (First-Name Last-Name): ")).split(" ")
        row["First_Name"] = name[0]
        row["Last_Name"] = name[1]
        row["Employee_ID"] = input("Employee ID(CHAR 6): ")
        
        q2 = "SELECT Employee_ID from EMPLOYEE"
        rowNum = cur.execute(q2)
        # fetch all the matching rows
        result = cur.fetchall()

        title = [i[0] for i in cur.description]
        entry = []
        for j in range(rowNum):
            entry.append([result[j-1][k] for k in title])
        print(tabulate(entry, headers=title, tablefmt='psql'))
        
        supID = input("Supervisor ID(6): ")
        if supID == "":
            supID = None
        else:
            row["Supervisor_ID"] = supID

        bday = input("Birth Date (YYYY-MM-DD): ")
        if bday == "":
            bday = None
        else:
            row["Date_of_Birth"] = bday
        row["Working_hours"] = int(input("Working hours: "))
        row["Salary"] = float(input("Salary: "))
        
        if(supID != None and bday != None):
            query = "INSERT INTO EMPLOYEE VALUES('%s', '%s', '%s', '%s', '%s', %d, %f)" % (
                row["First_Name"],
                row["Last_Name"],
                row["Employee_ID"],
                row["Supervisor_ID"],
                row["Date_of_Birth"],
                row["Working_hours"],
                row["Salary"],
            )
        elif(supID == None and bday != None):
            query = "INSERT INTO EMPLOYEE VALUES('%s', '%s', '%s', '%s', %d, %f)" % (
                row["First_Name"],
                row["Last_Name"],
                row["Employee_ID"],
                row["Date_of_Birth"],
                row["Working_hours"],
                row["Salary"],
            )
        elif (supID != None and bday == None):
            query = "INSERT INTO EMPLOYEE VALUES('%s', '%s', '%s', '%s', %d, %f)" % (
                row["First_Name"],
                row["Last_Name"],
                row["Employee_ID"],
                row["Supervisor_ID"],
                row["Working_hours"],
                row["Salary"],
            ) 
        else:
            query = "INSERT INTO EMPLOYEE VALUES('%s', '%s', '%s', %d, %f)" % (
                    row["First_Name"],
                    row["Last_Name"],
                    row["Employee_ID"],
                    row["Working_hours"],
                    row["Salary"],
                ) 
            
        print(query)
        cur.execute(query)
        con.commit()

        print("Inserted Into Database")

    except Exception as e:
        con.rollback()
        print("Failed to insert into database")
        print("ERROR: ", e)

    return


# INSERT PASSENGER
def inPassenger():
    try:
        # Takes passenger details as input
        row = {}
        print("Enter new passenger's details: ")
        name = (input("Name (FirstName LastName): ")).split(" ")
        row["First_Name"] = name[0]
        row["Last_Name"] = name[1]
        row["Passenger_ID"] = input("Passenger ID(CHAR 5): ")
        bday = input("Birth Date (YYYY-MM-DD): ")
        if bday == "":
            bday = None
        else:
            row["Date_of_Birth"] = bday
        
        gen = input("Gender(M/F/O): ")
        if gen == "":
            gen = None
        else:
            row["Gender"] = gen
        
        if(gen != None and bday != None):
            query = "INSERT INTO PASSENGER VALUES('%s', '%s', '%s', '%s', '%c')" % (
            row["Passenger_ID"],
            row["First_Name"],
            row["Last_Name"],
            row["Date_of_Birth"],
            row["Gender"],
        )
            
        elif(gen == None and bday != None):
            query = "INSERT INTO PASSENGER VALUES('%s', '%s', '%s', '%s')" % (
            row["Passenger_ID"],
            row["First_Name"],
            row["Last_Name"],
            row["Date_of_Birth"],
        )
            
        elif (gen != None and bday == None):
            query = "INSERT INTO PASSENGER VALUES('%s', '%s', '%s', '%s', '%c')" % (
            row["Passenger_ID"],
            row["First_Name"],
            row["Last_Name"],
            row["Gender"],
        )
        else:
            query = "INSERT INTO PASSENGER VALUES('%s', '%s', '%s')" % (
            row["Passenger_ID"],
            row["First_Name"],
            row["Last_Name"],
        ) 
        print(query)
        cur.execute(query)
        con.commit()
        
        ch = input("Enter 0 for Student, 1 for Military, 2 for neither: ")
        if(ch == 0):
            sid = int(input("Enter Student ID (6-digit): "))
            query2 ="INSERT INTO STUDENT VALUES('%s', %d)" % (
            row["Passenger_ID"], sid)
            print(query2)
            cur.execute(query2)
            con.commit()
        elif(ch == 1):
            mid = int(input("Enter Military ID (8-digit): "))
            query3 ="INSERT INTO MILITARY VALUES('%s', %d)" % (
            row["Passenger_ID"], mid)
            print(query3)
            cur.execute(query3)
            con.commit()

        print("Inserted Into Database")

    except Exception as e:
        con.rollback()
        print("Failed to insert into database")
        print("ERROR: ", e)

    return


# INSERT TICKET
def bookTkt():
    try:
        # Takes ticket details as input
        row = {}
        print("Enter new ticket's details: ")
        row["Ticket_ID"] = input("Ticket ID(NUM 6): ")
        row["Dept_Date"] = input("Date of Departure (YYYY-MM-DD): ")
        row["Dept_Time"] = input("Time of Departure (hh:mm:ss): ")
        row["Arr_Date"] = input("Date of Arrival (YYYY-MM-DD): ")
        row["Arr_Time"] = input("Time of Arrival (hh:mm:ss): ")

        query = "INSERT INTO TICKET VALUES('%s', '%s', '%s', '%s', '%s')" % (
            row["Ticket_ID"],
            row["Dept_Date"],
            row["Dept_Time"],
            row["Arr_Date"],
            row["Arr_Time"],
        )

        print(query)
        cur.execute(query)
        con.commit()

        print("Inserted Into Database")

    except Exception as e:
        con.rollback()
        print("Failed to insert into database")
        print("ERROR: ", e)

    return

############# DELETIONS #############

# DELETE TICKET
def cancelTkt():
    try:
        tktID = input("Enter Ticket ID(NUM 6): ")
        query = "DELETE FROM TICKET WHERE Ticket_ID = %s" % (tktID)
        print(query)
        cur.execute(query)
        con.commit()
        print("Deleted From Database")

    except Exception as e:
        con.rollback()
        print("Failed to delete from database")
        print("ERROR: ", e)


# DELETE EMPLOYEE
def fireEmp():
    try:
        empID = input("Enter Employee ID(CHAR 6): ")
        query = "DELETE FROM EMPLOYEE WHERE Employee_ID = '%s'" % (empID)
        print(query)
        cur.execute(query)
        con.commit()
        print("Deleted From Database")

    except Exception as e:
        con.rollback()
        print("Failed to delete from database")
        print("ERROR: ", e)

############# UPDATIONS #############

# UPDATE PASSENGER BIRTHDAY
def upPas():
    try:
        passID = input("Enter Passenger ID(CHAR 5): ")
        bday = input("Enter birthdate(YYYY-MM-DD): ")
        gen = input("Enter Gender(M/F/O): ")
        
        if(gen == "" and bday != ""):
            query = "UPDATE PASSENGER SET Date_of_Birth='%s' WHERE Passenger_ID = '%s'" % (
                bday,
                passID,
            )
        elif(bday == "" and gen != ""):
            query = "UPDATE PASSENGER SET Gender='%c' WHERE Passenger_ID = '%s'" % (
                gen,
                passID,
            )
        elif(bday != "" and gen != ""):
            query = "UPDATE PASSENGER SET Date_of_Birth='%s', Gender='%c' WHERE Passenger_ID = '%s'" % (
                bday,
                gen,
                passID,
            )
            
        print(query)
        cur.execute(query)
        con.commit()
        print("Updated Database")

    except Exception as e:
        con.rollback()
        print("Failed to update database")
        print("ERROR: ", e)


# UPDATE EMPLOYEE DETAILS
def upEmp():
    try:
        empID = input("Enter Employee ID(CHAR 6): ")
        ch1 = int(input("Want to update Supervisor ID? (Enter 1 for Yes or 0 for No): "))
        if(ch1 == 1):   
            supID = input("Enter Supervisor ID (CHAR 6): ")
            query = "UPDATE EMPLOYEE SET Supervisor_ID='%s' WHERE Employee_ID = '%s'" % (
                supID,
                empID,
            )
            print(query)
            cur.execute(query)
            con.commit()
        ch2 = int(input("Want to update Date of Birth? (Enter 1 for Yes or 0 for No): "))
        if(ch2 == 1):    
            bday = input("Enter birthdate(YYYY-MM-DD): ")
            query = "UPDATE EMPLOYEE SET Date_of_Birth='%s' WHERE Employee_ID = '%s'" % (
                bday,
                empID,
            )
            print(query)
            cur.execute(query)
            con.commit()
        ch3 = int(input("Want to update Working Hours (Enter 1 for Yes or 0 for No): "))
        if(ch3 == 1):    
            wkh = int(input("Enter Working Hours (2-digit): "))
            query = "UPDATE EMPLOYEE SET Working_hours=%d WHERE Employee_ID = '%s'" % (
                wkh,
                empID,
            )
            print(query)
            cur.execute(query)
            con.commit()
        ch4 = int(input("Want to update Salary (Enter 1 for Yes or 0 for No): "))
        if(ch4 == 1):   
            sal = float(input("Enter Salary: "))
            query = "UPDATE EMPLOYEE SET Salary=%f WHERE Employee_ID = '%s'" % (
                sal,
                empID,
            )
            print(query)
            cur.execute(query)
            con.commit()
            print("Updated Database")
        
    except Exception as e:
        con.rollback()
        print("Failed to update database")
        print("ERROR: ", e)


# UPDATE TRAIN DETAILS
def upTrain():
    try:
        tn = input("Enter Train Number (NUM 5): ")
        dpt = input("Enter Departure Time(hh:mm:ss): ")
        art = input("Enter Arrival Time(hh:mm:ss): ")
        
        if(dpt == "" and art != ""):
            query = (
            "UPDATE TRAIN_DETAILS SET Arr_time='%s' WHERE Train_number = %s"
            % (art, tn)
        )
        elif(dpt != "" and art == ""):
            query = (
            "UPDATE TRAIN_DETAILS SET Dept_time='%s' WHERE Train_number = %s"
            % (dpt, tn)
        )
        elif(dpt != "" and art != ""):
            query = (
            "UPDATE TRAIN_DETAILS SET Dept_time='%s', Arr_time='%s' WHERE Train_number = %s"
            % (dpt, art, tn)
        )
        
        print(query)
        cur.execute(query)
        con.commit()
        print("Updated Database")

    except Exception as e:
        con.rollback()
        print("Failed to update database")
        print("ERROR: ", e)

############# SELECTION #############

# Search Ticket info of Families
def searchTkt():
    try:
        ln = input("Enter Last Name of Family: ")
        query = (
            "select * from TRAVEL JOIN PASSENGER USING (Passenger_ID) where Last_Name like '%%%s%%'"
            % (ln)
        )
        rowNum = cur.execute(query)

        # fetch all the matching rows
        result = cur.fetchall()

        title = [i[0] for i in cur.description]
        entry = []
        for j in range(rowNum):
            entry.append([result[j-1][k] for k in title])
        print(tabulate(entry, headers=title, tablefmt='psql'))

    except Exception as e:
        con.rollback()
        print("ERROR: ", e)

def searchEmpName(): 
    try:
        fn = input("Enter First Name of Employee: ")
        ln = input("Enter Last Name of Employee: ")
        
        if(fn == "" and ln != ""):
            query = (
                "select * from EMPLOYEE where Last_Name like '%%%s%%'"
                % (ln)
            )
        if(fn != "" and ln == ""):
            query = (
                "select * from EMPLOYEE where First_Name like '%%%s%%'"
                % (fn)
            )
        if(fn != "" and ln != ""):
            query = (
                "select * from EMPLOYEE where First_Name like '%%%s%%' and Last_Name like '%%%s%%'"
                % (fn, ln)
            )
        rowNum = cur.execute(query)

        # fetch all the matching rows
        result = cur.fetchall()

        title = [i[0] for i in cur.description]
        entry = []
        for j in range(rowNum):
            entry.append([result[j-1][k] for k in title])
        print(tabulate(entry, headers=title, tablefmt='psql'))

    except Exception as e:
        con.rollback()
        print("ERROR: ", e)


# Search for Train info based on Name
def searchTrainName():
    try:
        tn = input("Enter Name of Train: ")
        query = (
            "select DISTINCT TRAIN_DETAILS.Train_number,TRAVEL.Train_name, Arr_Station_Name,Arr_date, Arr_time, Dept_Station_Name, Dept_date, Dept_time from TRAVEL JOIN TRAIN_DETAILS USING (Train_number) where TRAVEL.Train_name like '%%%s%%'"
            % (tn)
        )
        rowNum = cur.execute(query)
        # fetch all the matching rows
        result = cur.fetchall()

        title = [i[0] for i in cur.description]
        entry = []
        for j in range(rowNum):
            entry.append([result[j-1][k] for k in title])
        print(tabulate(entry, headers=title, tablefmt='psql'))

    except Exception as e:
        con.rollback()
        print("ERROR: ", e)


# Search for Train info based on Dept_date
def searchTrainDate():
    try:
        dd = input("Enter Departure Date (YYYY-MM-DD): ")
        query = (
            "select DISTINCT TRAIN_DETAILS.Train_number, TRAVEL.Train_name, Arr_Station_Name,Arr_date, Arr_time, Dept_Station_Name, Dept_date, Dept_time,Distance from TRAVEL JOIN TRAIN_DETAILS USING (Train_number) where Dept_date='%s'"
            % (dd)
        )
        rowNum = cur.execute(query)
        # fetch all the matching rows
        result = cur.fetchall()

        title = [i[0] for i in cur.description]
        entry = []
        for j in range(rowNum):
            entry.append([result[j-1][k] for k in title])
        print(tabulate(entry, headers=title, tablefmt='psql'))

    except Exception as e:
        con.rollback()
        print("ERROR: ", e)


# Search for Train info based on Arrival Station
def searchTrainStation():
    try:
        ast = input("Enter Arrival Station Name: ")
        query = (
            "select DISTINCT TRAVEL.Train_name, Arr_Station_Name,Arr_date, Arr_time, Dept_Station_Name, Dept_date, Dept_time from TRAVEL JOIN TRAIN_DETAILS USING (Train_number) where TRAVEL.Arr_Station_Name like '%%%s%%'"
            % (ast)
        )
        rowNum = cur.execute(query)
        # fetch all the matching rows
        result = cur.fetchall()

        title = [i[0] for i in cur.description]
        entry = []
        for j in range(rowNum):
            entry.append([result[j-1][k] for k in title])
        print(tabulate(entry, headers=title, tablefmt='psql'))
        
    except Exception as e:
        con.rollback()
        print("ERROR: ", e)


# Search for employees working on day
def searchEmp():
    try:
        day = input("Enter Day(Mon/Tue/Wed/Thu/Fri/Sat/Sun): ")
        query = (
            "select * from EMPLOYEE JOIN EMP_WORKING_DAYS USING (Employee_ID) where Day like '%%%s%%'"
            % (day)
        )
        rowNum = cur.execute(query)
        # fetch all the matching rows
        result = cur.fetchall()

        title = [i[0] for i in cur.description]
        entry = []
        for j in range(rowNum):
            entry.append([result[j-1][k] for k in title])
        print(tabulate(entry, headers=title, tablefmt='psql'))
        
    except Exception as e:
        con.rollback()
        print("ERROR: ", e)

############# PROJECTION #############

# Select trains having 2+ passengers
def tPas():
    try:
        query = "select Train_name from TRAVEL group by Train_name having count(Train_number) >= 2"

        rowNum = cur.execute(query)
        # fetch all the matching rows
        result = cur.fetchall()

        title = [i[0] for i in cur.description]
        entry = []
        for j in range(rowNum):
            entry.append([result[j-1][k] for k in title])
        print(tabulate(entry, headers=title, tablefmt='psql'))
        
    except Exception as e:
        con.rollback()
        print("ERROR: ", e)


# Select trains having more than 50 available seats
def tSeat():
    try:
        query = "select Train_name FROM (SEAT JOIN COACH ON SEAT.Coach_ID = COACH.Coach_ID JOIN TRAIN ON COACH.Train_num = TRAIN.Train_number) WHERE Availability = 'A' AND Seat_num > 50"
        cur.execute(query)

        rowNum = cur.execute(query)
        # fetch all the matching rows
        result = cur.fetchall()

        title = [i[0] for i in cur.description]
        entry = []
        for j in range(rowNum):
            entry.append([result[j-1][k] for k in title])
        print(tabulate(entry, headers=title, tablefmt='psql'))

    except Exception as e:
        con.rollback()
        print("ERROR: ", e)


# Passengers paid by Credit Card
def crPay():
    try:
        query = "Select First_Name, Last_Name from PASSENGER JOIN TRAVEL USING (Passenger_ID) JOIN FARE USING (Ticket_ID) WHERE Payment_type LIKE '%%Credit%%'"
        rowNum = cur.execute(query)
        # fetch all the matching rows
        result = cur.fetchall()

        title = [i[0] for i in cur.description]
        entry = []
        for j in range(rowNum):
            entry.append([result[j-1][k] for k in title])
        print(tabulate(entry, headers=title, tablefmt='psql'))

    except Exception as e:
        con.rollback()
        print("ERROR: ", e)


# First Class Passengers
def fcSeat():
    try:
        query = "SELECT Passenger_ID, First_Name, Last_Name, Date_of_Birth, Gender FROM PASSENGER JOIN TRAVEL USING  (Passenger_ID) JOIN COACH ON TRAVEL.Train_number = COACH.Train_num JOIN SEAT USING (Coach_ID) WHERE Seat_type = '1A'"
        rowNum = cur.execute(query)
        # fetch all the matching rows
        result = cur.fetchall()

        title = [i[0] for i in cur.description]
        entry = []
        for j in range(rowNum):
            entry.append([result[j-1][k] for k in title])
        print(tabulate(entry, headers=title, tablefmt='psql'))

    except Exception as e:
        con.rollback()
        print("ERROR: ", e)

############# AGGREGATE #############

# Average num of Passengers
def avgPas():
    try:
        query = "select avg(count) from (select count(*) as Count from TRAVEL group by Train_name) as counts"
        rowNum = cur.execute(query)
        # fetch all the matching rows
        result = cur.fetchall()

        title = [i[0] for i in cur.description]
        entry = []
        for j in range(rowNum):
            entry.append([result[j-1][k] for k in title])
        print(tabulate(entry, headers=title, tablefmt='psql'))
        
    except Exception as e:
        con.rollback()
        print("ERROR: ", e)


# Maximum Working hours
def maxWH():
    try:
        query = "select * FROM EMPLOYEE Where Working_hours = (SELECT MAX(Working_hours) FROM EMPLOYEE)"
        rowNum = cur.execute(query)
        # fetch all the matching rows
        result = cur.fetchall()

        title = [i[0] for i in cur.description]
        entry = []
        for j in range(rowNum):
            entry.append([result[j-1][k] for k in title])
        print(tabulate(entry, headers=title, tablefmt='psql'))

    except Exception as e:
        con.rollback()
        print("ERROR: ", e)


# Maximum Discount
def maxD():
    try:
        query = "select * from PASSENGER JOIN DISCOUNT USING (Passenger_ID) WHERE Refund_amt = (SELECT MAX(Refund_amt) FROM DISCOUNT)"
        rowNum = cur.execute(query)
        # fetch all the matching rows
        result = cur.fetchall()

        title = [i[0] for i in cur.description]
        entry = []
        for j in range(rowNum):
            entry.append([result[j-1][k] for k in title])
        print(tabulate(entry, headers=title, tablefmt='psql'))

    except Exception as e:
        con.rollback()
        print("ERROR: ", e)


# Total fares
def totF():
    try:
        query = "SELECT SUM(Amount) AS TOTAL FROM FARE"
        rowNum = cur.execute(query)
        # fetch all the matching rows
        result = cur.fetchall()

        title = [i[0] for i in cur.description]
        entry = []
        for j in range(rowNum):
            entry.append([result[j-1][k] for k in title])
        print(tabulate(entry, headers=title, tablefmt='psql'))

    except Exception as e:
        con.rollback()
        print("ERROR: ", e)


# Maximum Ticket
def maxTK():
    try:
        query = "select MAX(Amount) from FARE"
        rowNum = cur.execute(query)
        # fetch all the matching rows
        result = cur.fetchall()

        title = [i[0] for i in cur.description]
        entry = []
        for j in range(rowNum):
            entry.append([result[j-1][k] for k in title])
        print(tabulate(entry, headers=title, tablefmt='psql'))

    except Exception as e:
        con.rollback()
        print("ERROR: ", e)


# Minimum Ticket
def minTK():
    try:
        query = "select MIN(Amount) from FARE"
        rowNum = cur.execute(query)
        # fetch all the matching rows
        result = cur.fetchall()

        title = [i[0] for i in cur.description]
        entry = []
        for j in range(rowNum):
            entry.append([result[j-1][k] for k in title])
        print(tabulate(entry, headers=title, tablefmt='psql'))

    except Exception as e:
        con.rollback()
        print("ERROR: ", e)


# Military Passenger Trains
def mPSG():
    try:
        query = "SELECT Train_name FROM TRAVEL JOIN MILITARY USING (Passenger_ID);"
        rowNum = cur.execute(query)
        # fetch all the matching rows
        result = cur.fetchall()

        title = [i[0] for i in cur.description]
        entry = []
        for j in range(rowNum):
            entry.append([result[j-1][k] for k in title])
        print(tabulate(entry, headers=title, tablefmt='psql'))

    except Exception as e:
        con.rollback()
        print("ERROR: ", e)


# First Class Stations
def fCT():
    try:
        query = "SELECT distinct Arr_Station_Name, Dept_Station_Name FROM TRAVEL WHERE Train_number = (SELECT Train_number AS Occurence FROM TRAVEL JOIN COACH ON TRAVEL.Train_number = COACH.Train_num WHERE Coach_type = 'First AC' GROUP BY Train_number ORDER BY COUNT(Train_number) DESC LIMIT 1)"
        rowNum = cur.execute(query)
        # fetch all the matching rows
        result = cur.fetchall()

        title = [i[0] for i in cur.description]
        entry = []
        for j in range(rowNum):
            entry.append([result[j-1][k] for k in title])
        print(tabulate(entry, headers=title, tablefmt='psql'))

    except Exception as e:
        con.rollback()
        print("ERROR: ", e)


# Student Seat Types
def sST():
    try:
        query = "SELECT Seat_type FROM TRAVEL JOIN STUDENT USING (Passenger_ID) JOIN COACH ON COACH.Train_num = TRAVEL.Train_number JOIN SEAT USING (Coach_ID)"
        rowNum = cur.execute(query)
        # fetch all the matching rows
        result = cur.fetchall()

        title = [i[0] for i in cur.description]
        entry = []
        for j in range(rowNum):
            entry.append([result[j-1][k] for k in title])
        print(tabulate(entry, headers=title, tablefmt='psql'))

    except Exception as e:
        con.rollback()
        print("ERROR: ", e)


# More than avg Passengers
def mavgT():
    try:
        query = "select Train_name, count(*) as Count from TRAVEL group by Train_name having Count > (select avg(Cnt) from (select count(*) as Cnt from TRAVEL group by Train_name) as counts);"
        rowNum = cur.execute(query)
        # fetch all the matching rows
        result = cur.fetchall()

        title = [i[0] for i in cur.description]
        entry = []
        for j in range(rowNum):
            entry.append([result[j-1][k] for k in title])
        print(tabulate(entry, headers=title, tablefmt='psql'))

    except Exception as e:
        con.rollback()
        print("ERROR: ", e)


# Preferred payment method of station
def stP():
    try:
        st = input("Input station name: ")
        query = (
            "SELECT Payment_type FROM TRAVEL JOIN FARE USING (Ticket_ID) WHERE Dept_Station_Name LIKE '%%%s%%' GROUP BY Payment_type ORDER BY COUNT(Payment_type) DESC LIMIT 1"
        ) % (st)
        rowNum = cur.execute(query)
        # fetch all the matching rows
        result = cur.fetchall()

        title = [i[0] for i in cur.description]
        entry = []
        for j in range(rowNum):
            entry.append([result[j-1][k] for k in title])
        print(tabulate(entry, headers=title, tablefmt='psql'))

    except Exception as e:
        con.rollback()
        print("ERROR: ", e)


# Function that maps helper functions to option entered
def dispatch(ch):

    if ch == 1:
        hireEmp()
    elif ch == 2:
        inPassenger()
    elif ch == 3:
        bookTkt()
    elif ch == 4:
        cancelTkt()
    elif ch == 5:
        fireEmp()
    elif ch == 6:
        upPas()
    elif ch == 7:
        upEmp()
    elif ch == 8:
        upTrain()
    elif ch == 9:
        searchTkt()
    elif ch == 10:
        searchEmpName()
    elif ch == 11:
        searchTrainName()
    elif ch == 12:
        searchTrainDate()
    elif ch == 13:
        searchTrainStation()
    elif ch == 14:
        searchEmp()
    elif ch == 15:
        tPas()
    elif ch == 16:
        tSeat()
    elif ch == 17:
        crPay()
    elif ch == 18:
        fcSeat()
    elif ch == 19:
        avgPas()
    elif ch == 20:
        maxWH()
    elif ch == 21:
        maxD()
    elif ch == 22:
        totF()
    elif ch == 23:
        maxTK()
    elif ch == 24:
        minTK()
    elif ch == 25:
        mPSG()
    elif ch == 26:
        fCT()
    elif ch == 27:
        sST()
    elif ch == 28:
        mavgT()
    elif ch == 29:
        stP()
    elif ch == 30:
        exit()
    else:
        print("Error: Invalid Option")


# Global
while (1):
    tmp = sp.call("clear", shell=True)

    # Can be skipped if you want to hardcode username and password
    username = input("Username: ")
    password = input("Password: ")
    
    try:
        # Set db name accordingly which have been create by you
        # Set host to the server's address if you don't want to use local SQL server
        """
        con = pymysql.connect(
            host="localhost",
            user="jv",
            password="pwd123",
            db="rail",
            cursorclass=pymysql.cursors.DictCursor,
        )
        """
        con = pymysql.connect(host='localhost',
                              user=username,
                              password=password,
                              db='rail',
                              port=3306,
                              cursorclass=pymysql.cursors.DictCursor)
        
        tmp = sp.call("clear", shell=True)

        if con.open:
            print("Connected to SQL")
        else:
            print("Failed to connect")

        tmp = input("Enter any key to CONTINUE>")

        with con.cursor() as cur:
            while 1:
                tmp = sp.call("clear", shell=True)

                print("1. Hire an Employee")
                print("2. Input Passenger Details")
                print("3. Book a Ticket")
                print("4. Cancel Ticket")
                print("5. Fire Employee")
                print("6. Update Passenger Birthdate")
                print("7. Update Employee Work Timings")
                print("8. Update Train Timings")
                print("9. Show Ticket details of Family")
                print("10. Search for Employee Details(name)")
                print("11. Search for Train(name)")
                print("12. Show all Trains leaving on (date)")
                print("13. Show all Trains arriving on (station)")
                print("14. Show all employees working on day")
                print("15. Name trains having more than 2 passenger")
                print("16. Name trains having more than 50 available seats")
                print("17. Name passengers who have paid by credit card")
                print("18. Name passengers having a first class seat")
                print("19. Calculate avg passengers on train")
                print("20. Max working hours")
                print("21. Max discount")
                print("22. Total fares so far")
                print("23. Max ticket price of train")
                print("24. Min ticket price of train")
                print("25. Look for trains having military passengers")
                print(
                    "26. Stations having trains with maximum first class ticket bookings"
                )
                print("27. Seat types preferred by student passengers")
                print("28. Trains having more than average number of passengers")
                print("29. Payment method preferred by passengers of station")
                print("30. Exit")
                ch = int(input("Enter choice> "))
                tmp = sp.call("clear", shell=True)
                if ch == 30:
                    exit()
                else:
                    dispatch(ch)
                    tmp = input("Enter any key to CONTINUE>")

    except Exception as e:
        tmp = sp.call("clear", shell=True)
        print(e)
        print(
            "Connection Refused: Either username or password is incorrect or user doesn't have access to database"
        )
        tmp = input("Enter any key to CONTINUE>")