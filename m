From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Wed, 06 Jul 2016 16:18:23 +0000
Subject: Re: [PATCH v5 20/22] sh: IO-DATA HDL-U (a.k.a landisk) DeviceTree
Message-Id: <87zipuloz4.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
	<1467564402-2649-21-git-send-email-ysato@users.sourceforge.jp>
	<c7ea8230-c307-0d53-b98f-d72f9f5ca083@cogentembedded.com>
In-Reply-To: <c7ea8230-c307-0d53-b98f-d72f9f5ca083@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 04 Jul 2016 04:00:59 +0900,
Sergei Shtylyov wrote:
> 
> Hello.
> 
> On 07/03/2016 07:46 PM, Yoshinori Sato wrote:
> 
> > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> 
> [...]
> 
> > diff --git a/arch/sh/boot/dts/landisk.dts b/arch/sh/boot/dts/landisk.dts
> > new file mode 100644
> > index 0000000..3745ae0
> > --- /dev/null
> > +++ b/arch/sh/boot/dts/landisk.dts
> > @@ -0,0 +1,61 @@
> [...]
> > +&oclk {
> > +	clock-frequency = <22222222>;
> > +};
> > +
> > +&sci0 {
> > +	status = "ok";
> 
>    Should be "okay". Sorry for overlooking it.
> 
> > +};
> > +
> > +&sci1 {
> > +	status = "ok";
> 
>    Likewise.
> 
> [...]
> 
> MBR, Sergei
>

Updated.
Thanks.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>
