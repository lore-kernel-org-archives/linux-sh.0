From: James Hogan <james.hogan@imgtec.com>
Date: Tue, 18 Jun 2013 08:51:59 +0000
Subject: Re: [PATCH v7 0/3] SH pinctrl DT support
Message-Id: <51C01FAF.8050006@imgtec.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1371495003-11185-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <CACRpkdZh709J3pFsfbReQ20LU5W0Q1HacE0ZpssWXofKTJJ6pQ@mail.gmail.com>
In-Reply-To: <CACRpkdZh709J3pFsfbReQ20LU5W0Q1HacE0ZpssWXofKTJJ6pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>

On 18/06/13 09:05, Linus Walleij wrote:
> On Mon, Jun 17, 2013 at 8:50 PM, Laurent Pinchart
> <laurent.pinchart+renesas@ideasonboard.com> wrote:
> 
>> Hello,
>>
>> Here's the seventh (and hopefully final) version of the SuperH and SH Mobile
>> pin controllers (PFC) DT support patch set.
>>
>> The patches have been rebased on the for-next branch of the pinctrl
>> repository. All ARM-specific patches have been dropped and will be pushed
>> through to ARM SoC tree in v3.12. This series thus only contains DT support
>> for the sh-pfc driver.
>>
>> I've tried merging Simon's latest tag (renesas-next-20130617v3) with these
>> patches and no conflict occurred. Linus, would it finally be possible to get
>> this applied for v3.11 ?
>>
>> Changes since v6:
>>
>> - Added generic pinconf support back
>> - Dropped all ARM-specific patches
> 
> Thanks, this looks really nice and I've applied all three.
> 
> Heiko, James can you have a look from a generic pinconf
> point of view so we are sure we get this right? (Looks right
> to me atleast.)

The generic pinconf stuff in these patches looks reasonable to me.

Should we be standardizing the pins/groups/function properties too,
since the strings are pretty much passed straight through? The usage
seems pretty similar between the drivers I've seen (except ugly vendor
prefixes), so we could presumably get away with a single implementation
of dt_node_to_map?

Cheers
James

