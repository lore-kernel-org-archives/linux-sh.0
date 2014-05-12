From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Mon, 12 May 2014 13:48:24 +0000
Subject: Re: [PATCH 4/4] clk: shmobile: Add R8A7740-specific clock support
Message-Id: <CAO3366zzTd7OpSkgXHiF+d1BvTXtGvypd3GB0NOAim_W5U6chg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1398172752-30567-5-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1398172752-30567-5-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, May 7, 2014 at 4:57 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, Apr 22, 2014 at 3:19 PM, Ulrich Hecht <ulrich.hecht@gmail.com> wrote:
>> +struct div4_clk {
>> +       const char *name;
>> +       unsigned int reg;
>> +       unsigned int shift;
>> +       unsigned int mask;
>> +       int flags;
>
> mask and flags are unused.

mask will eventually be used once setting the divider is implemented.
As for flags, its usefulness is indeed questionable (see my comment on
the sh73a0 device tree part).

CU
Uli
