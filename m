From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 07 May 2013 19:46:29 +0000
Subject: Re: [PATCH v6 3/3] ARM: shmobile: BOCK-W: add USB support
Message-Id: <51895A15.4090006@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201305010309.07744.sergei.shtylyov@cogentembedded.com>
 <201305010314.32153.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201305010314.32153.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 05/01/2013 03:14 AM, Sergei Shtylyov wrote:

> Register the USB PHY device from bockw_init(), passing the platform  data to it.
> Set machine's init_late() method to r8a7778_init_late() in order for [EO]HCI to
> get registered too...
>
> The patch has been tested on the BOCK-W board.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

    Oops, the patch misses the USB pin setup. The USB pin groups in the 
sh-pfc
driver have also not been created. This needs to be addressed in the 
next iteration...

WBR, Sergei

