From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 17 Feb 2009 03:49:14 +0000
Subject: Re: [PATCH] sh: fix INTC group handling
Message-Id: <aec7e5c30902161949i59d727e2gf20fb1ef11cdd3c8@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <499015A0.9060105@renesas.com>
In-Reply-To: <499015A0.9060105@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Shimoda-san,

On Mon, Feb 9, 2009 at 8:38 PM, Yoshihiro Shimoda
<shimoda.yoshihiro@renesas.com> wrote:
> In a grouped interrupt such as DMAC of SH7785, there was the problem that
> a certain interrupt masked the other interrupts when it was masked.
>
> Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>

I'll NAK this patch for now, please have look at the following patch
and see if it solves your problem:

http://patchwork.kernel.org/patch/6812/

Thank you!

/ magnus
