From: Ezequiel Garcia <elezegarcia@gmail.com>
Date: Sat, 09 Jun 2012 12:01:50 +0000
Subject: Re: [PATCH 1/6] sh: fix compiler warning by properly inlining flat_set_persistent()
Message-Id: <CALF0-+WsZnEho0-bPonCjPnsUtaMUmMnDwKmrqBsNQW_cO0T+g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1339229611-2326-1-git-send-email-elezegarcia@gmail.com>
	<20120609091426.GA10170@linux-sh.org>
In-Reply-To: <20120609091426.GA10170@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-sh@vger.kernel.org

On Sat, Jun 9, 2012 at 6:14 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Sat, Jun 09, 2012 at 05:13:26AM -0300, Ezequiel Garcia wrote:
>> This patch removes the following warning:
>> fs/binfmt_flat.c:752: warning: unused variable ???persistent???
>> There is neither change in functionality, nor extra code generated.
>>
>> Cc: Paul Mundt <lethal@linux-sh.org>
>> Cc: <linux-sh@vger.kernel.org>
>> Signed-off-by: Ezequiel Garcia <elezegarcia@gmail.com>
>
> That's what the cast was for, with what gcc version did that stop
> working?

Mmm. You're right. I did this change first for m68k [1] and when that
went ok, I decided it
was best to propagate this fix to every other arch.

Originally, my first try was to propagate your cast:

#define        flat_set_persistent(relval, p)          ({ (void)p; 0; })

to the other arches, that just do:

#define        flat_set_persistent(relval, p)          0

But, then someone pointed out that inlining would produce some (nil) code
and it seemed better.
To conclude: sh was the only one doing it right, and there is no good
reason to change
it, except to make code more homogeneous.

Hope it is clear now,
Ezequiel.

[1] https://lkml.org/lkml/2012/5/21/491
