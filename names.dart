import 'enum.dart';
import 'dart:math' as math;

class Fullname{
    String _firstName = '';
    String _lastName = '';
    List<String> possibleMaleNames = ["Clifton","Hubbard","Daniel","Harmon","Damon","Holt","Frederick","Fields","Bernard","Horn","Merle","Whitehead","Jeff","Frey","Victor","Roy","Darrell","Phillips","Tony","Sharp","Israel","Andersen","Cecil","Thompson","Gabriel","Hamilton","Dan","Combs","Neal","Morrow","Terrence","Rowland","Steve","Warren","Julius","Parker","Louis","Morris","Russ","Conway","Emmanuel","Patrick","Jessie","Lozano","Bobby","Sloan","Saul","Ritter","Edgar","Brady","Andrew","Case","Duane","Bell","Ivan","Mendoza","Eddie","Atwood","Carroll","Flynn","Rene","Conrad","Cary","Ferguson","Roberto","Gorman","Jimmie","Nichols","Scott","Rogers","Vincent","Dugan","Maurice","Nichols","Adrian","Ellison","Harold","Gleason","Young","Booker","Leo","Pearson","Barry","Salinas","Armando","Weaver","Eric","Andrade","Sidney","Lyons","Zach","Zuniga","William","Grey","Milton","Fritz","Ricardo","Rush","Edward","Peters"];
    List<String> possibleFemaleNames = ["Dixie","Hogan","Leigh","Khan","Betsy","Myer","Candice","Kline","Rhonda","Moody","Jenna","Brown","Sheila","McMahon","Rachel","Singleton","Rita","Mays","Leah","Ritter","Sophia","Roberts","Natalie","Ward","Gabriela","Lewis","Rosie","Booker","Crystal","Crane","Patti","Blevins","Elsa","Mathis","Sonja","Lester","Iris","Bauer","Carrie","Irwin","Lourdes","Cramer","Susana","McIntosh","Antonia","Hess","Shannon","Meyers","Tasha","Gibson","Paula","Neal","Carmen","Minor","Nadine","Scott","Sonya","Charles","Cecilia","Reeves","Janine","Medina","Kay","McDowell","Fran","Franco","Sandra","Holland","Beth","Steward","Geneva","O'Brien","Nell","Welsh","Denise","Delgado","Joni","Calhoun","Abigail","Lloyd","Brenda","Johnson","Camille","Roach","Stefanie","Marquez","Janet","Branch","Michele","Butler","Rebekah","Bassett","Marcia","Lyons","Theresa","Carson","Natasha","Meadows","Francisca","Bright"];
    Fullname(Gender gender){
        switch(gender){
            case Gender.male:
                _firstName = possibleMaleNames[math.Random().nextInt(possibleMaleNames.length)];
                _lastName = possibleMaleNames[math.Random().nextInt(possibleMaleNames.length)];
                break;
            case Gender.female:
                _firstName = possibleFemaleNames[math.Random().nextInt(possibleFemaleNames.length)];
                _lastName = possibleFemaleNames[math.Random().nextInt(possibleFemaleNames.length)];
                break;
        }
    }
    get firstName{
        return _firstName;
    }
    get lastName{
        return _lastName;
    }
}