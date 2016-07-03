From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 03 Jul 2016 19:00:59 +0000
Subject: Re: [PATCH v5 20/22] sh: IO-DATA HDL-U (a.k.a landisk) DeviceTree
Message-Id: <c7ea8230-c307-0d53-b98f-d72f9f5ca083@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
 <1467564402-2649-21-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1467564402-2649-21-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 07/03/2016 07:46 PM, Yoshinori Sato wrote:

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

[...]

> diff --git a/arch/sh/boot/dts/landisk.dts b/arch/sh/boot/dts/landisk.dts
> new file mode 100644
> index 0000000..3745ae0
> --- /dev/null
> +++ b/arch/sh/boot/dts/landisk.dts
> @@ -0,0 +1,61 @@
[...]
> +&oclk {
> +	clock-frequency = <22222222>;
> +};
> +
> +&sci0 {
> +	status = "ok";

    Should be "okay". Sorry for overlooking it.

> +};
> +
> +&sci1 {
> +	status = "ok";

    Likewise.

[...]

MBR, Sergei

