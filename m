From: yoshii.takashi@gmail.com
Date: Tue, 14 Apr 2009 05:37:08 +0000
Subject: Re: [PATCH] sh-sci: fix SCBRR value calculation
Message-Id: <20090414143708.0bc57473.yoshii.takashi@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <ud4bf3jpm.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <ud4bf3jpm.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Please don't omit that term, that is for "round to near" operation.

round_to_near(clk/(32*bps)) -1
--> round_to_zero(clk/(32*bps) + 0.5) -1
--> (int)((clk+16*bps)/(32*bps)) -1

> -		return (clk+16*bps)/(32*bps)-1;
> +		return (clk/(32*bps)) - 1;
Former one is correct.

> -		return ((clk*2)+16*bps)/(16*bps)-1;
> +		return ((clk*2)/(16*bps)) - 1;
Both incorrect? Perhaps,
		return ((clk*2)+8*bps)/(16*bps) - 1;

I don't have read 7723 HW manual, though.
/yoshii
