From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 11 Dec 2014 14:38:04 +0000
Subject: Re: [PATCH v7 1/6] clk: shmobile: sh73a0 common clock framework implementation
Message-Id: <CAO3366ybJbcmqcp4V_pVJ6qf9Zeg0SvWaTFt_BOrEcJrs5gCLw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418222727-19888-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1418222727-19888-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 11, 2014 at 3:15 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Kzm9g still boots after
>   1) Setting z_div_table[1..15] to { 0, 0 }
>   2) Removing the lines that initialize CPG_SD[012]CKCR.

OK, that's all I need to know.  Thanks a lot for checking!

CU
Uli
