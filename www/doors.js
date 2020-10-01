Shiny.addCustomMessageHandler('door_to_open', function myFunction(door_numb) {
//    alert(door_numb.substring(0, 1))
    //   document.getElementById("demo").innerHTML = "Hello World";
        door_id = 'door'.concat(door_numb.substring(1, 2));
        label_id = 'front_lebel'.concat(door_numb.substring(0, 1));
        document.getElementById(door_id).style.transform = "rotateY(180deg)";
//          document.getElementById("door1_btn").disabled = true;
        document.getElementById("door1_btn").style.visibility = "hidden";
 //       document.getElementById("door2_btn").disabled = true;
        document.getElementById("door2_btn").style.visibility = "hidden";
//        document.getElementById("door3_btn").disabled = true;
        document.getElementById("door3_btn").style.visibility = "hidden";
        document.getElementById(label_id).innerHTML = 'Selected';
        document.getElementById(label_id).style.color = "red";
 //       document.getElementById("door1").style.background = "red";
        document.getElementById("change_option_btn").disabled = false;
        document.getElementById("not_change_option_btn").disabled = false;
    });
    

Shiny.addCustomMessageHandler('open_all_doors', function myFunction(golden_door) {
//    alert(selected_car_doors);
    door_with_car = 'doorimage'.concat(golden_door);
    document.getElementById(door_with_car).src = "car.jpeg";
    document.getElementById("change_option_btn").disabled = true;
    document.getElementById("not_change_option_btn").disabled = true;
    document.getElementById('door1').style.transform = "rotateY(180deg)";
    document.getElementById('door2').style.transform = "rotateY(180deg)";
    document.getElementById('door3').style.transform = "rotateY(180deg)";
    });
    
    
Shiny.addCustomMessageHandler('refresh_scene', function myFunction(doors) {
    document.getElementById('door1').style.transform = "rotateY(0deg)";
    document.getElementById('door2').style.transform = "rotateY(0deg)";
    document.getElementById('door3').style.transform = "rotateY(0deg)";
    document.getElementById('front_lebel1').innerHTML = 'Door 1';
    document.getElementById('front_lebel2').innerHTML = 'Door 2';
    document.getElementById('front_lebel3').innerHTML = 'Door 3';
    document.getElementById("door1_btn").style.visibility = "visible";
    document.getElementById("door2_btn").style.visibility = "visible";
    document.getElementById("door3_btn").style.visibility = "visible";
    document.getElementById('front_lebel1').style.color = "white";
    document.getElementById('front_lebel2').style.color = "white";
    document.getElementById('front_lebel3').style.color = "white";
    // for the following rounds, the door still keeps the car image, the following scripts make sure that all the doors
    // are goats before setting the one to car
    document.getElementById('doorimage1').src = "goat.jpg";
    document.getElementById('doorimage2').src = "goat.jpg";
    document.getElementById('doorimage3').src = "goat.jpg";
   });