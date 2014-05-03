From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 03 May 2014 15:51:45 +0000
Subject: Re: [PATCH v2 02/02] ARM: shmobile: Add SDHI devices for Koelsch DTS
Message-Id: <53651091.1040601@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140212095404.4832.61203.sendpatchset@w520>
In-Reply-To: <20140212095404.4832.61203.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 05/03/2014 04:11 AM, Sergei Shtylyov wrote:

>> From: Magnus Damm <damm@opensource.se>

>> Add DT support for SDHI0, SDHI1 and SDHI2 on Koelsch.

>> The board specific handling of CD and WP pins are
>> using GPIOs.

>     Frankly speaking, I didn't understand why. The native SDHI[012] CD/WP pins
> are used in the legacy Koelsch code, why not do the same in the device tree?

    Ah, after looking at the SDHI driver, it seems I've figured that out: it 
only can use GPIO for the CD signal, and the WP signal is ignored for R-Car 
gen2 SoCs, so that only GPIO can actually work... Now I'm wondering how the 
legacy code manages to work. :-)

>> SDHI0 and SDHI1 are hooked up to regular
>> SD connectors while SDHI2 is using micro-SD which
>> is lacking WP signal.

>> Signed-off-by: Magnus Damm <damm@opensource.se>

WBR, Sergei

