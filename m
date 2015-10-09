From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 09 Oct 2015 20:40:52 +0000
Subject: Re: [PATCH] ARM: shmobile: henninger: add MSIOF0 DT support
Message-Id: <56182654.6070205@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201405070048.00213.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201405070048.00213.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 05/07/2014 12:47 AM, Sergei Shtylyov wrote:

> Define the Henninger board dependent part of the MSIOF0 device node.
> Add device node for Renesas R2A11302FT PMIC for which no bindings exist yet.

    I've just realized that there's no such PMIC on the Henninger/Porter 
boards and MSIOF0 is only connected to CN6, hence this patch was wrong.
The .dts is going to be deleted anyway though...

> Based on the Koelsch MSIOF device tree patch by Geert Uytterhoeven.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

MBR, Sergei

