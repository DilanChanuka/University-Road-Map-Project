#pragma checksum "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "52f32e420e3f98f22504d0b1d4b0290a8f06d6db"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_API_AdminPanel), @"mvc.1.0.view", @"/Views/API/AdminPanel.cshtml")]
namespace AspNetCore
{
    #line hidden
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Microsoft.AspNetCore.Mvc.ViewFeatures;
#nullable restore
#line 1 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\_ViewImports.cshtml"
using Road_Map_Web_API;

#line default
#line hidden
#nullable disable
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"52f32e420e3f98f22504d0b1d4b0290a8f06d6db", @"/Views/API/AdminPanel.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"c7f9adec50aa2733e17f6e87dc180cd93b18364f", @"/Views/_ViewImports.cshtml")]
    public class Views_API_AdminPanel : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<IEnumerable<KeyValuePair<string, List<APIUser>>>>
    {
        #line hidden
        #pragma warning disable 0649
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperExecutionContext __tagHelperExecutionContext;
        #pragma warning restore 0649
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperRunner __tagHelperRunner = new global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperRunner();
        #pragma warning disable 0169
        private string __tagHelperStringValueBuffer;
        #pragma warning restore 0169
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager __backed__tagHelperScopeManager = null;
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager __tagHelperScopeManager
        {
            get
            {
                if (__backed__tagHelperScopeManager == null)
                {
                    __backed__tagHelperScopeManager = new global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager(StartTagHelperWritingScope, EndTagHelperWritingScope);
                }
                return __backed__tagHelperScopeManager;
            }
        }
        private global::Microsoft.AspNetCore.Mvc.TagHelpers.FormTagHelper __Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper;
        private global::Microsoft.AspNetCore.Mvc.TagHelpers.RenderAtEndOfFormTagHelper __Microsoft_AspNetCore_Mvc_TagHelpers_RenderAtEndOfFormTagHelper;
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            WriteLiteral("\r\n");
#nullable restore
#line 3 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
  
    ViewData["Title"] = "Admin Panel";

#line default
#line hidden
#nullable disable
            WriteLiteral(@"<header>
    <nav class=""navbar navbar-expand-sm navbar-toggleable-sm navbar-light bg-white border-bottom box-shadow mb-3"">
        <div class=""container justify-content-start"">
        </div>
        <div class=""container justify-content-center"">
            <a class=""navbar-brand"">University Roadmap Admin Panel</a>
        </div>
        <div class=""container justify-content-end"">
            <input class=""form-control"" id=""search"" onkeyup=""myFunction()"" type=""text"" placeholder=""Search the Username.. "" aria-label=""Search"">
        </div>
    </nav>
</header>
<script>
    function myFunction() {
        var txt = document.getElementById(""search"").value;
        $.ajax({
            type: ""POST"",
            url: '");
#nullable restore
#line 23 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
             Write(Url.Action("Search", "API", new { text = "Dilan" }));

#line default
#line hidden
#nullable disable
            WriteLiteral(@"'.replace(""Dilan"",txt),
            contentType: ""application/json"",
            dataType: ""json"",
            success: function (data) {
                $(""#fbody"").load(window.location.href + "" #fbody"");
            }
        });
    }

</script>

");
#nullable restore
#line 34 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
 if (@TempData["access"] != null)
{
    if (@TempData["access"].ToString() == "yes")
    {

#line default
#line hidden
#nullable disable
            WriteLiteral("        <div id=\"fbody\">\r\n");
#nullable restore
#line 39 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
             foreach (KeyValuePair<string, List<APIUser>> item in Model)
            {
                

#line default
#line hidden
#nullable disable
#nullable restore
#line 41 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
                 if (@TempData["searchText"] != null)
                {
                    

#line default
#line hidden
#nullable disable
#nullable restore
#line 43 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
                     if (@TempData["searchText"].ToString() == "*" || item.Value[0].username.ToLower().Contains(@TempData["searchText"].ToString().ToLower().Trim())
                      || @TempData["searchText"].ToString() == "" || (@TempData["searchText"].ToString().ToLower().Trim().Length == 1))
                    {

#line default
#line hidden
#nullable disable
            WriteLiteral("                        <div class=\"panel-group mt-2\" id=\"accordion\" role=\"tablist\" aria-multiselectable=\"true\">\r\n\r\n                            <div class=\"panel panel-default\">\r\n                                <div class=\"panel-heading\" role=\"tab\"");
            BeginWriteAttribute("id", " id=\"", 2018, "\"", 2042, 2);
            WriteAttributeValue("", 2023, "heading_", 2023, 8, true);
#nullable restore
#line 49 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
WriteAttributeValue("", 2031, item.Key, 2031, 11, false);

#line default
#line hidden
#nullable disable
            EndWriteAttribute();
            WriteLiteral(">\r\n                                    <div class=\"panel-title box-shadow p-4 pl-3 pr-3\">\r\n                                        <a role=\"button\" data-toggle=\"collapse\" data-parent=\"#accordion\"");
            BeginWriteAttribute("href", " href=\"", 2238, "\"", 2266, 2);
            WriteAttributeValue("", 2245, "#collapse_", 2245, 10, true);
#nullable restore
#line 51 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
WriteAttributeValue("", 2255, item.Key, 2255, 11, false);

#line default
#line hidden
#nullable disable
            EndWriteAttribute();
            WriteLiteral(" aria-expanded=\"true\"");
            BeginWriteAttribute("aria-controls", " aria-controls=\"", 2288, "\"", 2324, 2);
            WriteAttributeValue("", 2304, "collapse_", 2304, 9, true);
#nullable restore
#line 51 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
WriteAttributeValue("", 2313, item.Key, 2313, 11, false);

#line default
#line hidden
#nullable disable
            EndWriteAttribute();
            WriteLiteral(@" style=""text-decoration: none;"">
                                            <div class=""row d-flex justify-content-start"">
                                                <div class=""pl-3 d-inline-flex"">
                                                    <h3>");
#nullable restore
#line 54 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
                                                   Write(item.Value[0].username);

#line default
#line hidden
#nullable disable
            WriteLiteral("</h3>\r\n                                                    <span class=\"one pl-5 pt-2\"><i><p class=\"text-center\">");
#nullable restore
#line 55 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
                                                                                                     Write(item.Value[0].faculty);

#line default
#line hidden
#nullable disable
            WriteLiteral(" - (");
#nullable restore
#line 55 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
                                                                                                                               Write(item.Value[0].type);

#line default
#line hidden
#nullable disable
            WriteLiteral(")</p></i> </span>\r\n                                                </div>\r\n                                                <div class=\"pr-3 align-self-end ml-auto\">\r\n                                                    ");
            __tagHelperExecutionContext = __tagHelperScopeManager.Begin("form", global::Microsoft.AspNetCore.Razor.TagHelpers.TagMode.StartTagAndEndTag, "52f32e420e3f98f22504d0b1d4b0290a8f06d6db9854", async() => {
                WriteLiteral("\r\n                                                        <a");
                BeginWriteAttribute("href", " href=\"", 3054, "\"", 3137, 1);
#nullable restore
#line 59 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
WriteAttributeValue("", 3061, Url.Action("RemoveUser", "API", new { username = @item.Value[0].username }), 3061, 76, false);

#line default
#line hidden
#nullable disable
                EndWriteAttribute();
                WriteLiteral(" class=\"btn btn-outline-danger\" role=\"button\">Remove</a>\r\n                                                    ");
            }
            );
            __Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.TagHelpers.FormTagHelper>();
            __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper);
            __Microsoft_AspNetCore_Mvc_TagHelpers_RenderAtEndOfFormTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.TagHelpers.RenderAtEndOfFormTagHelper>();
            __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_TagHelpers_RenderAtEndOfFormTagHelper);
            await __tagHelperRunner.RunAsync(__tagHelperExecutionContext);
            if (!__tagHelperExecutionContext.Output.IsContentModified)
            {
                await __tagHelperExecutionContext.SetOutputContentAsync();
            }
            Write(__tagHelperExecutionContext.Output);
            __tagHelperExecutionContext = __tagHelperScopeManager.End();
            WriteLiteral(@"
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                                <div");
            BeginWriteAttribute("id", " id=\"", 3531, "\"", 3556, 2);
            WriteAttributeValue("", 3536, "collapse_", 3536, 9, true);
#nullable restore
#line 66 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
WriteAttributeValue("", 3545, item.Key, 3545, 11, false);

#line default
#line hidden
#nullable disable
            EndWriteAttribute();
            WriteLiteral(" class=\"panel-collapse collapse\" role=\"tabpanel\"");
            BeginWriteAttribute("aria-labelledby", " aria-labelledby=\"", 3605, "\"", 3642, 2);
            WriteAttributeValue("", 3623, "heading_", 3623, 8, true);
#nullable restore
#line 66 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
WriteAttributeValue("", 3631, item.Key, 3631, 11, false);

#line default
#line hidden
#nullable disable
            EndWriteAttribute();
            WriteLiteral(">\r\n                                    <div class=\"panel-body\">\r\n                                        <div class=\"row\">\r\n\r\n");
#nullable restore
#line 70 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
                                             for (int i = 1; i < item.Value.Count; i++)
                                            {


#line default
#line hidden
#nullable disable
            WriteLiteral("                                                <div class=\"col-md-2 text-center mt-1 m-3 p-3 box-shadow\">\r\n                                                    <h5>");
#nullable restore
#line 74 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
                                                   Write(item.Value[i].username);

#line default
#line hidden
#nullable disable
            WriteLiteral(" <br></h5>\r\n                                                    <p>");
#nullable restore
#line 75 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
                                                  Write(item.Value[i].faculty);

#line default
#line hidden
#nullable disable
            WriteLiteral("<br>(");
#nullable restore
#line 75 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
                                                                             Write(item.Value[i].type);

#line default
#line hidden
#nullable disable
            WriteLiteral(")</p>\r\n                                                    <a");
            BeginWriteAttribute("href", " href=\"", 4268, "\"", 4385, 1);
#nullable restore
#line 76 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
WriteAttributeValue("", 4275, Url.Action("UnfriendUser", "API", new { user_1 = @item.Value[0].username, user_2 = @item.Value[i].username }), 4275, 110, false);

#line default
#line hidden
#nullable disable
            EndWriteAttribute();
            WriteLiteral(" class=\"btn btn-outline-info\" role=\"button\">Unfriend</a>\r\n                                                </div>\r\n");
#nullable restore
#line 78 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"

                                            }

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                                        </div>\r\n                                    </div>\r\n                                </div>\r\n                            </div>\r\n                        </div>\r\n");
#nullable restore
#line 86 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
                    }

#line default
#line hidden
#nullable disable
#nullable restore
#line 86 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
                     
                }

#line default
#line hidden
#nullable disable
#nullable restore
#line 87 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
                 
            }

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n        </div>\r\n        <div class=\"d-none\">\r\n");
#nullable restore
#line 92 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
             if (@TempData["status"] != null)
            {
                

#line default
#line hidden
#nullable disable
#nullable restore
#line 94 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
                 if (@TempData["status"].ToString() == "yes")
                {

#line default
#line hidden
#nullable disable
            WriteLiteral(@"                    <script>
                        Swal.fire({
                            position: 'bottom-center',
                            icon: 'success',
                            title: 'User Deleted..!',
                            showConfirmButton: false,
                            timer: 1500
                        });
                    </script>
");
#nullable restore
#line 105 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
                }

#line default
#line hidden
#nullable disable
#nullable restore
#line 106 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
                 if (@TempData["status"].ToString() == "no")
                {

#line default
#line hidden
#nullable disable
            WriteLiteral(@"                    <script>
                        Swal.fire({
                            position: 'bottom-center',
                            icon: 'error',
                            title: ""Couldn't complete the requested operation..!"",
                            showConfirmButton: false,
                            timer: 1500
                        });
                    </script>
");
#nullable restore
#line 117 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
                }

#line default
#line hidden
#nullable disable
#nullable restore
#line 118 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
           Write(TempData.Remove("status"));

#line default
#line hidden
#nullable disable
#nullable restore
#line 118 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
                                          ;
            }

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n\r\n\r\n");
#nullable restore
#line 123 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
             if (@TempData["removestatus"] != null)
            {
                

#line default
#line hidden
#nullable disable
#nullable restore
#line 125 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
                 if (@TempData["removestatus"].ToString() == "yes")
                {

#line default
#line hidden
#nullable disable
            WriteLiteral(@"                    <script>
                        Swal.fire({
                            position: 'bottom-center',
                            icon: 'success',
                            title: 'User unfriend successfully..!',
                            showConfirmButton: false,
                            timer: 1500
                        });
                    </script>
");
#nullable restore
#line 136 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
                }

#line default
#line hidden
#nullable disable
#nullable restore
#line 137 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
                 if (@TempData["removestatus"].ToString() == "no")
                {

#line default
#line hidden
#nullable disable
            WriteLiteral(@"                    <script>
                        Swal.fire({
                            position: 'bottom-center',
                            icon: 'error',
                            title: ""Couldn't complete the requested operation..!"",
                            showConfirmButton: false,
                            timer: 1500
                        });
                    </script>
");
#nullable restore
#line 148 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
                }

#line default
#line hidden
#nullable disable
#nullable restore
#line 149 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
           Write(TempData.Remove("removestatus"));

#line default
#line hidden
#nullable disable
#nullable restore
#line 149 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
                                                ;
            }

#line default
#line hidden
#nullable disable
            WriteLiteral("        </div>\r\n");
            WriteLiteral("        <div class=\"d-none\">\r\n            ");
#nullable restore
#line 154 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
       Write(TempData.Remove("access"));

#line default
#line hidden
#nullable disable
            WriteLiteral(";\r\n        </div>\r\n");
#nullable restore
#line 156 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
    }
    else
    {

#line default
#line hidden
#nullable disable
            WriteLiteral("        <h1 class=\"justify-content-center\">\r\n            You have no permission to directly access this area..!\r\n        </h1>\r\n        <h2 class=\"text-danger justify-content-center\">\r\n            Please prove your identity.\r\n        </h2>\r\n");
#nullable restore
#line 165 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
    }
}
else
{

#line default
#line hidden
#nullable disable
            WriteLiteral("    <h1 class=\"justify-content-center\">\r\n        You have no permission to directly access this area..!\r\n    </h1>\r\n    <h2 class=\"text-danger justify-content-center\">\r\n        Please prove your identity.\r\n    </h2>\r\n");
#nullable restore
#line 175 "C:\Users\DILANCHANUKALASANTHA\Desktop\latest\Web API\Road-Map-Web-API\Road-Map-Web-API\Views\API\AdminPanel.cshtml"
}

#line default
#line hidden
#nullable disable
        }
        #pragma warning restore 1998
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.ViewFeatures.IModelExpressionProvider ModelExpressionProvider { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IUrlHelper Url { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IViewComponentHelper Component { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IJsonHelper Json { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<IEnumerable<KeyValuePair<string, List<APIUser>>>> Html { get; private set; }
    }
}
#pragma warning restore 1591