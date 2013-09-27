From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 27 Sep 2013 14:08:31 +0000
Subject: Re: [PATCH/RFC v4] ARM: shmobile: armadillo800eva-reference: add SDHI and MMCIF interfaces
Message-Id: <CACRpkdYpmUYg2ok2QHM2XB=pbG-kApX=C=YLMzMCZ95R_M8YAg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1309231651230.11505@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1309231651230.11505@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Sep 27, 2013 at 2:55 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:

> Is there a way to patch the device tree in the board code init function to
> turn "disabled" into "okay" based on the state of a GPIO ?

Can't you just locate the node using of_find_node_by_path()
or whatever and then use this:
int of_update_property(struct device_node *np, struct property *newprop)?

It's not like I'm a master of DT but... I'd very much like to know as well,
because it'd be very useful :-)

Yours,
Linus Walleij
