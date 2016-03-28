From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 28 Mar 2016 14:17:51 +0000
Subject: Re: Availability of SH hardware?
Message-Id: <56F93D0F.2080403@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20160317032441.GA22517@brightrain.aerifal.cx>
In-Reply-To: <20160317032441.GA22517@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

(CC'ing everyone who might want a NextVoD)

Just a quick update:

Paul Liu is willing to acquire several NextVoD boxes which he will
either send over to Germany or hand them over at DebConf16 in
South Africa.

In any case, I thought at a 10 Euro pricetag, I would be happy to
send such a NextVoD box to anyone doing SuperH kernel or gcc
development, that is:

 * Rich
 * Geert
 * Yoshinori
 * Oleg
 * Kaz
 * Zoltan

Anyone else?

See the quoted email for the detailed specs below. But I think we
won't find any other SH4 hardware with a 450 MHz CPU, 256 MiB
RAM and HDMI output for the same or less money.

Adrian

On 03/25/2016 09:31 PM, John Paul Adrian Glaubitz wrote:
> On 03/17/2016 10:10 AM, John Paul Adrian Glaubitz wrote:
>> So, with Renesas out of the picture, sources for SuperH hardware would
>> be either open source people in Japan who used to work for Renesas -
>> I know, for fact, that Renesas hired lots of people in Japan to work
>> on SuperH support in Linux - or third-party companies like emtrion [1]
>> or Alpha Project in Japan [2]. Another option would be getting an
>> old LANDisk device which can also be used to run Debian's sh4 port [3].
> 
> So, while reading the SH4 page in the Debian wiki [1], I stumbled
> accross another very interesting SH4 machine, the NextVOD from
> Taiwan [2] (Chinese name: 網樂通).
> 
> The specs [3] look very promising:
> 
>  * SH7105 CPU running at 600 MHz (other sources claim 450 MHz)
>  * 256 MiB RAM
>  * 8 GiB Flash storage (through an internal USB stick)
>  * Ethernet
>  * USB 2.0
>  * HDMI
>  * AV out
> 
> Apparently Paul Liu (another Debian guy from Taiwan I know personally)
> has or had such a device as well. At least he's got a filesystem image
> in his Debian webspace [4].
> 
> I will get in touch with him. Maybe he can help us acquire multiple
> boxes from Taiwan for little money.
> 
> Adrian
> 
>> [1] https://wiki.debian.org/SH4
>> [2] http://www.techbang.com/posts/4504-one-television-report-lok-tong-demo
>> [3] http://digiland.tw/viewtopic.php?id71
>> [4] http://people.debian.org.tw/~paulliu/nextvod/
> 


-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
