From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 03 May 2014 00:11:08 +0000
Subject: Re: [PATCH v2 02/02] ARM: shmobile: Add SDHI devices for Koelsch DTS
Message-Id: <5364341C.9030105@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140212095404.4832.61203.sendpatchset@w520>
In-Reply-To: <20140212095404.4832.61203.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 02/12/2014 12:54 PM, Magnus Damm wrote:

> From: Magnus Damm <damm@opensource.se>

> Add DT support for SDHI0, SDHI1 and SDHI2 on Koelsch.

> The board specific handling of CD and WP pins are
> using GPIOs.

    Frankly speaking, I didn't understand why. The native SDHI[012] CD/WP pins 
are used in the legacy Koelsch code, why not do the same in the device tree?

> SDHI0 and SDHI1 are hooked up to regular
> SD connectors while SDHI2 is using micro-SD which
> is lacking WP signal.

> Signed-off-by: Magnus Damm <damm@opensource.se>

PS: I've done some limited testing of the SDHI using the dedicated CD/WP pins 
on both Koelsch and Henninger boards; I haven't tested card insertion/removal 
since I only have remote access to the boards and it's holiday in Russia 
anyway. :-)

WBR, Sergei

