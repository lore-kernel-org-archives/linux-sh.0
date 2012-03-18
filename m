From: Bastian Hecht <hechtb@googlemail.com>
Date: Sun, 18 Mar 2012 14:13:07 +0000
Subject: Re: [PATCH] mtd: sh_flctl: Add power management support
Message-Id: <CABYn4swpzrmpcSw_KgUOBsWUrigBdiH1yeRuf58Jqmc1S32+-w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1331393478-30850-1-git-send-email-hechtb@gmail.com>
 <1331637313.3595.10.camel@sauron.fi.intel.com>
In-Reply-To: <1331637313.3595.10.camel@sauron.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dedekind1@gmail.com
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mtd@lists.infradead.org, Laurent Pichart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org

2012/3/13 Artem Bityutskiy <dedekind1@gmail.com>:
> On Sat, 2012-03-10 at 16:31 +0100, Bastian Hecht wrote:
>> All transactions with the NAND chip require a chip enable signal. So we
>> wrap the runtime_pm_get()/put()s around it. As registers are cached, we
>> need no suspend()/resume() callbacks.
>>
>> Signed-off-by: Bastian Hecht <hechtb@gmail.com>
>
> Pushed to l2-mtd.git, thanks.

Ouch, I've realized that I've sent an old incorrect version where 2
code blocks are swapped.
I write to the device before calling runtime_pm_get().

As I was on the way to a new version anyway, I've finished it today
and suggest you drop this one and consider pushing the new one. I post
it after this mail. Sorry.

Best regards,

 Bastian Hecht


> --
> Best Regards,
> Artem Bityutskiy
