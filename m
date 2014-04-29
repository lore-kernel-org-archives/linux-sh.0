From: Simon Horman <horms@verge.net.au>
Date: Tue, 29 Apr 2014 07:35:04 +0000
Subject: Re: [PATCH v4 05/11] ARM: shmobile: r7s72100: genmai: add uart aliases and activate scif2 as console
Message-Id: <20140429073501.GA3050@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1398704521-23767-1-git-send-email-wsa@the-dreams.de>
 <1398704521-23767-6-git-send-email-wsa@the-dreams.de>
 <CANqRtoTHy+-ac0kWY5a9MdYN0=jwWdeuOus9CVBckmas32_hSQ@mail.gmail.com>
 <20140429072143.GA2732@katana>
In-Reply-To: <20140429072143.GA2732@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Apr 29, 2014 at 09:21:43AM +0200, Wolfram Sang wrote:
> Hi Magnus,
> 
> > Thanks for your updated series. For this patch I only have a minor
> > comment. I believe we only want to enable the serial port that is used
> > on the board. At the same time we want to keep the same ordering as
> > the legacy code. I believe you keep the same order already and only
> > enable ttySC2, but I wonder if you really need all the aliases above?
> > Perhaps it is possible to keep just serial2?
> 
> Yeah, this is easily possible. I wanted to add the additional aliases
> because the other SCIF pins are available on the external connectors and
> wanted potential users to save some hassle. Let me know if you think
> this is not needed and I will resend this patch only taking care of
> SCIF2.

It seems that when enabling devices in DT there is a preference
for only enabling devices that are actually exposed on the board.

So at the risk of being contradicted by Magnus and others
my recommendation is to remove the aliases that Magnus highlighted.

