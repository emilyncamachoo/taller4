using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class InternetManager : MonoBehaviour
{
    public Text checkInternet;

    private string urlData = "http://tadeolabhack.com:8081/test/Datos/unityphp/isConection.php";

    // Start is called before the first frame update
    void Start()
    {
        StartCoroutine(_checkInternet());
    }

    public IEnumerator _checkInternet()
    {
        //www se usa para acceder a una pagina web, retornandio datos de tipo WWW object
        WWW getData = new WWW(urlData);
        yield return getData;

        print(getData.text);

        

    }



}
