From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 20 Feb 2015 20:04:07 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790: add ADSP clocks
Message-Id: <54E79337.9090500@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1909663.BCLINDXhVH@wasted.cogentembedded.com>
In-Reply-To: <1909663.BCLINDXhVH@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 12/30/2014 11:21 PM, Sergei Shtylyov wrote:

> Add the ADSP clocks to the CPG and MSTP5 nodes of the R8A7790 device tree.

> Based on the original patch by Konstantin Kozhevnikov
> <konstantin.kozhevnikov@cogentembedded.com>.

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> ---
> The patch is against 'renesas-devel-20141229-v3.19-rc2' tag of Simon Horman's
> 'renesas.git' repo plus the R8A7790 CAN patches posted earlier. It depends on
> the patch adding the ADSP clock support to the 'clk-rcar-gen2' driver in order
> to work.

    Simon, please consider merging this patch as well.

WBR, Sergei

