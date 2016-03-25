From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 25 Mar 2016 23:02:51 +0000
Subject: Re: Availability of SH hardware?
Message-Id: <56F5C39B.2090004@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20160317032441.GA22517@brightrain.aerifal.cx>
In-Reply-To: <20160317032441.GA22517@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 03/25/2016 11:51 PM, John Paul Adrian Glaubitz wrote:
> On 03/25/2016 11:42 PM, Rich Felker wrote:
>> This sounds really interesting. Do you know what cpu model it actually
>> has? I tried to lookup SH7105 and it seems to be a model of SH2, which
>> would not run Debian and almost certainly would not go up to 600 MHz.

Here's a kernel tree for this SoC:

> https://github.com/suzuke/kernel-pdk7105

And this Chinese page has some info on running Debian:

> https://sites.google.com/site/debiansh4/home

Apparently the name is not "SH-7105" but "ST-7105" and "ST-9150"
could be a newer version of the SoC.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
