From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 21 Mar 2014 14:32:12 +0000
Subject: Re: [PATCH v4 6/9] ARM: shmobile: Add PCIe device tree nodes for R8A7790
Message-Id: <532C5B70.5060509@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>
 <1395397968-6242-7-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1395397968-6242-7-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 03/21/2014 01:32 PM, Phil Edworthy wrote:

> This patch adds the device tree nodes for R8A7790

> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
>   arch/arm/boot/dts/r8a7790.dtsi | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)

    Why are you not enabling PCIe for Lager, only on Koelsch?

WBR, Sergei

