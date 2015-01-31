From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 31 Jan 2015 10:18:11 +0000
Subject: Re: [PATCH v2 12/13] ARM: shmobile: alt dts: Add chosen/stdout-path
Message-Id: <CAMuHMdUoc0f0WReqx86Qe35zwnbT3j49q5b+fFHupQa+3QsKag@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1412349104-18724-1-git-send-email-geert+renesas@glider.be>
	<1412349104-18724-13-git-send-email-geert+renesas@glider.be>
	<54CC06A4.9040408@cogentembedded.com>
In-Reply-To: <54CC06A4.9040408-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Sergei,

On Fri, Jan 30, 2015 at 11:33 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 10/03/2014 07:11 PM, Geert Uytterhoeven wrote:
>> Add a stdout-path property so that automatic console selection works
>> in the absence of a "console=" parameter on the kernel command line.
>
>> Note that we have to keep the "console=ttySC0,38400" parameter in
>> chosen/bootargs, else the console will use the default setting of 115200
>> baud.
>
>    I've looked at the code and it appears that one can still specify a baud
> rate after ':' even in the "stdout-path" prop.

That's correct. I believe that support was added later.
Can you please send a patch?

Spaciba!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
