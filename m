From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 12 Mar 2013 11:37:52 +0000
Subject: Re: [PATCH 3/3 v2] ARM: shmobile: add R-Car M1A Bock-W platform support
Message-Id: <513F1390.4070702@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d2v5rpck.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d2v5rpck.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 12-03-2013 12:31, Kuninori Morimoto wrote:

> Add basic Bock-W board support

> More devices will be added on top of this patch after
> PICNTRL and clock framework are in better shape.

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[...]

> diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
> new file mode 100644
> index 0000000..876616d
> --- /dev/null
> +++ b/arch/arm/boot/dts/r8a7778-bockw.dts
> @@ -0,0 +1,32 @@
[...]
> +/ {
> +	model = "bockw";
> +	compatible = "renesas,bockw", "renesas,r8a7778";

    Shouldn't the above coincide with the below?

> diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
> new file mode 100644
> index 0000000..18f2bf2
> --- /dev/null
> +++ b/arch/arm/mach-shmobile/board-bockw.c
[...]
> +static const char *bockw_boards_compat_dt[] __initdata = {
> +	"renesas,bockw-reference",
> +	NULL,
> +};

WBR, Sergei

