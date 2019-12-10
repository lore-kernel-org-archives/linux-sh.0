From: Rob Landley <rob@landley.net>
Date: Tue, 10 Dec 2019 20:20:08 +0000
Subject: Re: [PATCH][resend] sh: kgdb: Mark expected switch fall-throughs
Message-Id: <b220b69e-575d-0530-0f2d-65584df36ea2@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <87o8wgy3ra.wl-kuninori.morimoto.gx@renesas.com>
 <35e63e37-6ec8-8a47-8e18-639c954732e0@landley.net>
In-Reply-To: <35e63e37-6ec8-8a47-8e18-639c954732e0@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Will Deacon <will@kernel.org>, Douglas Anderson <dianders@chromium.org>, Paul Burton <paul.burton@mips.com>, Christophe Leroy <christophe.leroy@c-s.fr>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org



On 12/10/19 2:12 PM, Rob Landley wrote:
> On 12/10/19 2:38 AM, Kuninori Morimoto wrote:
>>
>> Hi Andrew
>>
>> I'm posting this patch from few month ago,
>> but it seems SH maintainer is not working in these days...
> 
> Again, I dunno where you're getting that.
> 
> (Me, I removed the -Werror...)

In fact I looked it up, _I_ didn't remove the -Werror, Rich acked a patch
removing the -Werror back in August:

  https://www.spinics.net/lists/linux-sh/msg55405.html

Rob
