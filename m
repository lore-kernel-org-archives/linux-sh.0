From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Dec 2019 00:45:58 +0000
Subject: Re: [PATCH] sh: use generic strncpy()
Message-Id: <87zhfpywft.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878snajjh2.wl-kuninori.morimoto.gx@renesas.com>
        <CAMuHMdUq6U0i_+Dg57jVNYM4iephuZ8k3QC6AyQ--W_qY5=q9w@mail.gmail.com>
In-Reply-To: <CAMuHMdUq6U0i_+Dg57jVNYM4iephuZ8k3QC6AyQ--W_qY5=q9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Karl Nasrallah <knnspeed@aol.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>


Hi Geert

Thank you for your review

> > But, current SH strnpy() has 2 issues.
> > 1st is it will access to out-of-memory (= src + 10).
> 
> I believe this is not correct: the code does not really access memory
> beyond the end of the source string.  (Recent) gcc just thinks so,
> because "__src+__n" is used as a parameter to the routine.

I see.
Will fix in v2

Thank you for your help !!
Best regards
---
Kuninori Morimoto
