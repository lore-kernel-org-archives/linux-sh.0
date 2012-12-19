From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 19 Dec 2012 15:31:00 +0000
Subject: Re: [PATCH v3 00/81] SH pin control and GPIO rework
Message-Id: <CACRpkdbR9zrggXX46y74foikW7qBB8WSDGX_xLe1iBc1nd0eiQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1355611915-25060-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1355611915-25060-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Dec 15, 2012 at 11:50 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> I would like to push this set to v3.9 independently of the later rework and
> OF-related sets. Linus and Simon, which tree would you like me to push this
> through ?

The pinctrl or sh tree obviously :-)

Basically if you believe there will be colissions with other stuff in
the sh tree
it should go in through that tree. Obviously there is little risk of collissions
in the pinctrl tree as this is a new driver.

You can add my Acked-by: to the entire patch set, since the result at
the end is super-nice.

I think there were review comments of mine that were not fixed yet,
but I trust you to go through that and fix it up as time goes by.

Yours,
Linus Walleij
