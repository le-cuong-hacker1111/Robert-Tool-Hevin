using System;
using System.Collections.Generic;
using System.Management;
using System.Text.RegularExpressions;
using System.Windows.Forms;

namespace League_IP
{
  internal class Lolip
  {
    [STAThread]
    private static void Main(string[] args)
    {
      List<string> list = new Lolip().wmi_process();
      if (list.Count < 1)
        return;
      Console.WriteLine("LOLIP - Modified by HackerPro536 - HVNGroups.Net");
      Console.WriteLine("\nIP: " + list[0]);
      Console.WriteLine("Port: " + list[1]);
      Clipboard.SetText("perl hvn.pl " + list[0] + " " + list[1] + " 1024 600");
      Console.ReadLine();
    }

    private List<string> wmi_process()
    {
      string input = "";
      List<string> list1 = new List<string>();
      try
      {
        foreach (ManagementBaseObject managementBaseObject in new ManagementObjectSearcher("root\\CIMV2", "SELECT * FROM Win32_Process WHERE Caption = 'League of Legends.exe'").Get())
          input = managementBaseObject["CommandLine"].ToString();
      }
      catch (ManagementException ex)
      {
        Console.WriteLine("An error occurred while querying for WMI data: " + ex.Message);
      }
      if (input.Length <= 1)
        return list1;
      string pattern = "\"";
      IList<int> list2 = (IList<int>) new List<int>();
      foreach (Match match in Regex.Matches(input, pattern))
        list2.Add(match.Index);
      int num = list2[list2.Count - 2];
      string str1 = input.Substring(num + 1);
      string str2 = str1.Substring(0, str1.IndexOf(' ') + 1);
      string str3 = str1.Substring(str2.Length, 4);
      string str4 = str2.Trim();
      string str5 = str3.Trim();
      list1.Add(str4);
      list1.Add(str5);
      return list1;
    }
  }
}
