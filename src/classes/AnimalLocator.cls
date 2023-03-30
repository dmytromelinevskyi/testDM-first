public class AnimalLocator
{

    public static String getAnimalNameById(Integer id)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+id);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        String currentAnimal = '';

        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200)
        {
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Map<String,Object> animals = (Map<String,Object>) results.get('animal');
            currentAnimal = String.valueOf(animals.get('name'));
        }
        return currentAnimal ;
    }

}