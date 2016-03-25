From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 25 Mar 2016 22:51:33 +0000
Subject: Re: Availability of SH hardware?
Message-Id: <56F5C0F5.4080809@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20160317032441.GA22517@brightrain.aerifal.cx>
In-Reply-To: <20160317032441.GA22517@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 03/25/2016 11:42 PM, Rich Felker wrote:
> This sounds really interesting. Do you know what cpu model it actually
> has? I tried to lookup SH7105 and it seems to be a model of SH2, which
> would not run Debian and almost certainly would not go up to 600 MHz.

Another post on a Taiwanese forum shows the SoC without the heat sink:

> http://digiland.tw/viewtopic.php?id71

This photo shows the type number of the SoC to be ST-9150:

>
http://www.st.com/web/catalog/mmc/FM128/SC1401/PF250067?sc=internet/imag_video/product/250067.jsp

Which is specified to contain an ST-40-300 core with 450 MHz:

>
http://www.st.com/st-web-ui/static/active/en/resource/technical/document/data_brief/CD00258048.pdf

And the ST-40-300 is claimed to be sh4a-compatible (page 33):

>
http://www.st.com/st-web-ui/static/active/en/resource/technical/document/reference_manual/CD17182230.pdf

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
