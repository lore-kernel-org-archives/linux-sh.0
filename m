From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 19 Aug 2009 10:24:06 +0000
Subject: Re: [PATCH] sh: USB0 resource area fix for ms7724se
Message-Id: <aec7e5c30908190324k367d1016p59e5673b4f3435bb@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uvdkk64rk.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uvdkk64rk.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 19, 2009 at 7:16 PM, Kuninori
Morimoto<morimoto.kuninori@renesas.com> wrote:
> I think strange register is SH7724 only.
> And the SH7724 board which use USB host is ms7724se only now.

Ok, I see. The driver does not seem to use this register at this point
so the change is mainly cosmetic.

Cheers,

/ magnus
