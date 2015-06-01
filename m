From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 01 Jun 2015 09:42:20 +0000
Subject: Re: [PATCH v4 4/4] ARM: shmobile: gose: enable R-Car Gen2 regulator quirk
Message-Id: <CAO3366x+Betarsp-JRRsad=11+H2jpcbTfLqBvUKNfSzSz1A-g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1432826157-6414-5-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1432826157-6414-5-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jun 1, 2015 at 11:27 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, May 28, 2015 at 5:15 PM, Ulrich Hecht
> <ulrich.hecht+renesas@gmail.com> wrote:
>> Regulator setup seems identical to Koelsch.
>>
>> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
>> ---
>>  arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c | 3 ++-
>
> Again, missing Makefile update?

I distinctly remember fixing that.  Must have fallen under table
reshuffling things, I guess.  I'll add it.

CU
Uli
