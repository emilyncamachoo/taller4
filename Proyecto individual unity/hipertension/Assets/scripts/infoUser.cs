using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class infoUser : MonoBehaviour
{
    private string UrlPosition = "http://tadeolabhack.com:8081/test/Datos/unityphp/MostrarPosXusuario.php";

    //private string UrlClicks = "http://tadeolabhack.com:8081/test/Datos/unityphp/MostrarBotonXusuario.php";

    public Text puesto;
    //public Text TextClick;

    public int id = 14;

    public void obtenerInfo()
    {
        StartCoroutine(datos());
    }

    public IEnumerator datos()
    {
        string info = UrlPosition + "?nombre=" + id;

        WWW resultInfo = new WWW(info);

        yield return resultInfo;

        print(resultInfo.text);

        puesto.text = resultInfo.text;

        //string info2 = UrlClicks + "?IDuser=" + id;

        //WWW resultInfo2 = new WWW(info2);

       // yield return resultInfo2;
       // print(resultInfo2.text);

       // TextClick.text = resultInfo2.text;


    }
}
