using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class UserData : MonoBehaviour
{
    private string getUrlEscribir = "http://tadeolabhack.com:8081/test/Datos/unityphp/escribir.php";

    //public int IdUser = 1;
    private string nombre = "";
    private int edad = 0;
    private int respuestas = 20;

    public InputField campoNombre;
    public InputField campoEdad;
    //public InputField campoRespuestas;

    public void SenData()
    {
        //es llamar a un metodo generando una pausa en la ejecución del programa hasta que se realiza lo que esta dentro del metodo
        StartCoroutine(enviarDatosUsuario());
    }

    private IEnumerator enviarDatosUsuario()
    {
        nombre = campoNombre.text;

        if (campoEdad.text != "")
        {
            edad = int.Parse(campoEdad.text);
        }
        else
        {
            print("el campo de edad no puede estar vacio");
        }

        print(nombre + "  " + edad + " " + respuestas);


        if (nombre == "" || edad == 0)
        {
            print("los campos de nombre y edad deben tener información");
        }
        else
        {
            WWWForm form = new WWWForm();
            //form.AddField("identificacion", IdUser);
            form.AddField("nom", nombre);
            form.AddField("ed", edad);
            form.AddField("res", respuestas);

            WWW retroalimentacion = new WWW(getUrlEscribir, form);
            yield return retroalimentacion;

            print(retroalimentacion.text);

        }



    }

}

