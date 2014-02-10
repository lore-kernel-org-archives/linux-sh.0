From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 10 Feb 2014 09:19:06 +0000
Subject: Re: [PATCH 02/03] pinctrl: sh-pfc: r8a7790: Break out USB0 OVC/VBUS
Message-Id: <CACRpkdahqPsFecErnLX_g=TaDzXA-AXZ-ghBZ=pffjDB7xVtOQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140129230959.22655.55645.sendpatchset@w520>
 <20140129231019.22655.41456.sendpatchset@w520>
In-Reply-To: <20140129231019.22655.41456.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Jan 30, 2014 at 12:10 AM, Magnus Damm <magnus.damm@gmail.com> wrote:

> From: Magnus Damm <damm@opensource.se>
>
> Create a new group for the USB0 OVC/VBUS pin by itself. This
> allows us to monitor PWEN as GPIO on the Lager board.
>
> Signed-off-by: Magnus Damm <damm@opensource.se>

Patch applied with Laurent's and Simon's ACKs.

Yours,
Linus Walleij
