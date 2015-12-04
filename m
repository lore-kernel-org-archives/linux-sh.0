From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 04 Dec 2015 08:34:17 +0000
Subject: Re: [PATCH 2/4] thermal: rcar: enable to use thermal-zone on DT
Message-Id: <CAMuHMdUe8kZdZ7-xS7B8J6LdaK7FAitE0Qms=vMAmNis24u7SA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <871tb2hpn2.wl%kuninori.morimoto.gx@renesas.com>
	<87y4dagb0i.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdUcQFcQuEmQZ4yMGwm=ouH+aQQhG3V95p=Pb56qWberQA@mail.gmail.com>
In-Reply-To: <CAMuHMdUcQFcQuEmQZ4yMGwm=ouH+aQQhG3V95p=Pb56qWberQA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Magnus <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, Dec 4, 2015 at 9:32 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> +Example (with thermal-zone):
>> +
>> +thermal-zones {
>> +       cpu_thermal: cpu-thermal {
>> +               polling-delay-passive   = <1000>;
>> +               polling-delay           = <5000>;
>> +
>> +               thermal-sensors = <&thermal>;
>> +
>> +               trips {
>> +                       cpu-crit {
>> +                               temperature     = <1150000>;
>> +                               hysteresis      = <0>;
>> +                               type            = "critical";
>> +                       };
>> +               };
>> +               cooling-maps {
>> +               };
>> +       };
>> +};
>> +
>> +thermal: thermal@e61f0000 {
>> +       compatible =    "renesas,thermal-r8a7790",
>> +                       "renesas,rcar-thermal-gen2",
>> +                       "renesas,rcar-thermal";
>> +       reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
>> +       interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
>> +       clocks = <&mstp5_clks R8A7790_CLK_THERMAL>;
>> +       power-domains = <&cpg_clocks>;
>> +       #thermal-sensor-cells = <0>;
>> +};
>
> How are the two nodes above linked?

Pleae ignore my comment, I found the "<&thermal>".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
