From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 04 Jun 2014 22:45:30 +0000
Subject: Re: [PATCH v3 3/7] r8a7790.dtsi: add vin[0-3] nodes
Message-Id: <538FA18A.4040505@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 04/14/2014 02:36 PM, Ben Dooks wrote:

> Add nodes for the four video input channels on the R8A7790.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>   arch/arm/boot/dts/r8a7790.dtsi | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)

    It looks like I've overlooked something while reviewing this patch back in 
April...

> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index a1e7c39..de0e53e 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
[...]
> @@ -395,6 +399,38 @@
>   		status = "disabled";
>   	};
>
> +	vin0: vin@0xe6ef0000 {

    Drop "0x" form the unit-address please. Also, name should probably be 
"video", more in line with the ePAPR standard...

WBR, Sergei

