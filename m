From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 24 Apr 2013 22:25:47 +0000
Subject: Re: [PATCH 2/4] sh-pfc: sh73a0: Add VCCQ MC0 regulator
Message-Id: <51785BEB.9000109@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1366672585-9098-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1366672585-9098-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 25-04-2013 1:20, Laurent Pinchart wrote:

>>> +static void __sh73a0_vccq_mc0_enable(struct regulator_dev *reg, bool
>>> enable)

>> Skip the __ and the confusing name "_enable" for a function that
>> does both enable and disable.

>> Call it sh73a0_vccq_mc0_endisable is my suggestion.

    Maybe sh73a0_vccq_mc0_control()?

> That's a weird name, but I can live with that.

    Yep, the name is weird.

WBR, Sergei

