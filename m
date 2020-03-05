From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 05 Mar 2020 20:56:15 +0000
Subject: Re: [PATCH] sh: Stop printing the virtual memory layout
Message-Id: <91C97773-5873-4336-9926-A013BB96B75C@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200305205158.GF6506@cisco>
In-Reply-To: <20200305205158.GF6506@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Tycho Andersen <tycho@tycho.ws>
Cc: Arvind Sankar <nivedita@alum.mit.edu>, Joe Perches <joe@perches.com>, Kees Cook <keescook@chromium.org>, "Tobin C . Harding" <me@tobin.cc>, kernel-hardening@lists.openwall.com, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org



> On Mar 5, 2020, at 9:52 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> 
> ﻿On Thu, Mar 05, 2020 at 10:56:29AM -0500, Arvind Sankar wrote:
>>> On Thu, Mar 05, 2020 at 04:49:22PM +0100, John Paul Adrian Glaubitz wrote:
>>> On 3/5/20 4:46 PM, Arvind Sankar wrote:
>>>> Not really too late. I can do s/pr_info/pr_devel and resubmit.
>>>> 
>>>> parisc for eg actually hides this in #if 0 rather than deleting the
>>>> code.
>>>> 
>>>> Kees, you fine with that?
>>> 
>>> But wasn't it removed for all the other architectures already? Or are these
>>> changes not in Linus' tree yet?
>>> 
>>> Adrian
>> 
>> The ones mentioned in the commit message, yes, those are long gone. But
>> I don't see any reason why the remaining ones (there are 6 left that I
>> submitted patches just now for) couldn't switch to pr_devel instead.
> 
> If you do happen to re-send with pr_debug() instead, feel free to add
> my ack to that series as well.

Since it already got removed for most other architectures, I don’t think it makes much sense to keep it for consistency.

I just didn’t understand why it was made configurable for debugging purposes in the first place.

Also, many distributions disable access to the kernel buffer for unprivileged users anyway.

Adrian
