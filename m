From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 31 Dec 2008 23:29:51 +0000
Subject: Re: SH7709 BUG on boot (partially bisected)
Message-Id: <20081231232950.GA29912@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <OF2E8062F8.007117EA-ON80257530.004D178D-80257530.004E3CFB@smsc.com>
In-Reply-To: <OF2E8062F8.007117EA-ON80257530.004D178D-80257530.004E3CFB@smsc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 31, 2008 at 02:13:23PM +0000, Steve.Glendinning@smsc.com wrote:
> Using the current torvalds tree on SH7709, physmap is having a problem 
> seeing my memory-mapped flash.  I've bisected this to somewhere between:
> 
> GOOD: [e9bf51e5ccc7703226c79888603e157066213700] sh: __udivdi3 -> do_div() 
> in softfloat lib.
> BAD: [3b041227f7ef7c7e97f205c68c6069c0c62e5204] sh: Add plain udivsi3 (not 
> _i4*) for gcc-4.1 and lower.
> 
> All commits between these two fail to boot here (no console output at 
> all), so I wasn't able to bisect further.
> 
Can you post your toolchain information? Compiler version is the most
important thing here.
