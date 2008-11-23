From: Luca Santini <luca.santini@spesonline.com>
Date: Sun, 23 Nov 2008 15:06:18 +0000
Subject: Re: git pull breaks edosk7760 kernel
Message-Id: <4929716A.6030207@spesonline.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4927F204.5090805@spesonline.com>
In-Reply-To: <4927F204.5090805@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Thanks Matt,
i tried to use git-bisect, and i hope i used it fine; this is my final output:




406f9e9cfe5d44fbcdc6e8f4b1f205e1160c0fef is first bad commit
commit 406f9e9cfe5d44fbcdc6e8f4b1f205e1160c0fef
Author: Paul Mundt <lethal@linux-sh.org>
Date:   Tue Nov 18 14:22:39 2008 +0900

    sh: __udivdi3 -> do_div() in softfloat lib.
    
    Inhibit the generation of __udivdi3 for the softfloat lib, use do_div()
    outright.
    
    Signed-off-by: Paul Mundt <lethal@linux-sh.org>

:040000 040000 70142433e2ab902b50182ea127ea1e56803dac87 7801a0a6ef1e2d6703f82fa82587ba03fe140048 M	arch




...and now?

Matt Fleming wrote:
> On Sat, Nov 22, 2008 at 12:50:28PM +0100, Luca Santini wrote:
>> Hi all,
>> yesterday i pulled from git and obtained an unbootable kernel.
>> My last working pull is dated
>>
>> commit 882b689432129bfe77530d61f70797147179a742
>> Merge: b86c2c0... fb059cd...
>> Author: Luca Santini <santox@libero.it>
>> Date:   Thu Nov 13 11:31:54 2008 +0100
>>
>>
>> The only thing i was able to do is git reset --hard HEAD^ 
>>
>> i'm not a god of git... is there a way to "pull step by step" and find the 
>> offending patch(es)? --
> 
> The usual way to find the commit that introduced a bug is via git-bisect.
> 
> Checkout http://www.kernel.org/doc/local/git-quick.html#bisect
> 
> 
