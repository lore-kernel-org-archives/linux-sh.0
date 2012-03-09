From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 09 Mar 2012 03:16:59 +0000
Subject: Re: [PATCH] sh/next: Fix build fail by asm/system.h in asm/bitops.h
Message-Id: <4F59762B.1000402@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1331010429-29574-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1331010429-29574-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Paul Mundt さんは書きました:
> On Tue, Mar 06, 2012 at 02:07:09PM +0900, Nobuhiro Iwamatsu wrote:
>> Other files are not done include definitely by asm/system.h made
>> include in asm/bitops.h.
>> This patch remove asm/system.h from asm/bitops.h.
>>
> Which defconfig were you using that hit this? asm/system.h is usually
> included for a reason, although I can't remember off the top of my head
> what's used out of it and on what CPU configuration, but I would be
> rather hesitant to yank it out on an N of 1 build test.
> 

Sorry, I checked sh7785lcr and ap325rxa and other.
We can confirm this problem in linux-next.

Nobuhiro
