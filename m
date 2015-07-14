From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 14 Jul 2015 10:28:48 +0000
Subject: Re: [PATCH] ARM: shmobile: rcar-gen2: CONFIG_ARM_ARCH_TIMER is always set
Message-Id: <CANqRtoT81PuL44tT=DEHDkhd0N1QssuH2z0ZZdg-E4uY4+Qriw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1436277927-20159-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1436277927-20159-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Wed, Jul 8, 2015 at 3:56 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> However, given CONFIG_HAVE_ARM_ARCH_TIMER was enabled in
> shmobile_defconfig before, I believe such an issue on CA7 would have been
> present before, when using shmobile_defconfig? Or were all CA7 users rolling
> their own config files, not enabling it?

I think they were rolling heir own config files!

Cheers,

/ magnus
