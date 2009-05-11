From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 11 May 2009 07:52:12 +0000
Subject: Re: [PATCH] sh: sh7785lcr: fix I2C device address map for 32-bit mode
Message-Id: <20090511075212.GA10944@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4A07CAF0.9080701@renesas.com>
In-Reply-To: <4A07CAF0.9080701@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, May 11, 2009 at 03:51:28PM +0900, Yoshihiro Shimoda wrote:
> Fix the problem that cannot work RTC on 32-bit mode.
> The cause is because the board datasheet had a mistake.
> 
> Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>

applied, thanks.
