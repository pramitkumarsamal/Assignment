Assignment 2- import requests

# API URL
API_URL = "https://samples.openweathermap.org/data/2.5/forecast/hourly?q=London,us&appid=b6907d289e10d714a6e88b30761fae22"

# Function to get temperature
def get_temperature(date_time):
    response = requests.get(API_URL)
    data = response.json()

    for forecast in data['list']:
        if forecast['dt_txt'] == date_time:
            temperature = forecast['main']['temp']
            return temperature
    return None

# Function to get wind speed
def get_wind_speed(date_time):
    response = requests.get(API_URL)
    data = response.json()

    for forecast in data['list']:
        if forecast['dt_txt'] == date_time:
            wind_speed = forecast['wind']['speed']
            return wind_speed
    return None

# Function to get pressure
def get_pressure(date_time):
    response = requests.get(API_URL)
    data = response.json()

    for forecast in data['list']:
        if forecast['dt_txt'] == date_time:
            pressure = forecast['main']['pressure']
            return pressure
    return None

# Main program loop
while True:
    print("Choose an option:")
    print("1. Get Temperature")
    print("2. Get Wind Speed")
    print("3. Get Pressure")
    print("0. Exit")

    option = input("Enter your choice: ")

    if option == '1':
        date_time = input("Enter date and time (YYYY-MM-DD HH:MM:SS): ")
        temperature = get_temperature(date_time)
        if temperature is not None:
            print(f"Temperature at {date_time}: {temperature}°C")
        else:
            print("Data not found for the specified date and time.")

    elif option == '2':
        date_time = input("Enter date and time (YYYY-MM-DD HH:MM:SS): ")
        wind_speed = get_wind_speed(date_time)
        if wind_speed is not None:
            print(f"Wind Speed at {date_time}: {wind_speed} m/s")
        else:
            print("Data not found for the specified date and time.")

    elif option == '3':
        date_time = input("Enter date and time (YYYY-MM-DD HH:MM:SS): ")
        pressure = get_pressure(date_time)
        if pressure is not None:
            print(f"Pressure at {date_time}: {pressure} hPa")
        else:
            print("Data not found for the specified date and time.")

    elif option == '0':
        print("Exiting the program.")
        break

    else:
        print("Invalid option. Please try again.")
