using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class cambio2 : MonoBehaviour
{
    public void ChangeScene(string escena)
    {
        SceneManager.LoadScene(2);
    }
}
