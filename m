From: Adrian McMenamin <adrianmcmenamin@gmail.com>
Date: Wed, 21 Mar 2012 08:32:59 +0000
Subject: Re: [PATCH] VMUFAT filesystem [2/4]
Message-Id: <CACwZE5TaUBLwsz0qMNqih9qnE1awP3i048ds-Say+xMAJXnMDA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAN628AE8gytYTE3eGDYrKR9Vx4JnND+OGzHcfneCb4q-QUM6cA@mail.gmail.com>
	<20120321053735.GO6589@ZenIV.linux.org.uk>
In-Reply-To: <20120321053735.GO6589@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Adrian McMenamin <lkmladrian@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, Linux-sh <linux-sh@vger.kernel.org>

On 21 March 2012 13:37, Al Viro <viro@zeniv.linux.org.uk> wrote:

...

OK, points essentially taken and will push through another patch in
due course ... just a couple of points, though:

* Did the defensive stuff because bad guys might inject evil code
rather than because I thought in normal run of execution there would
be an issue - guess I just have to forget that?

* On the semaphore - what should I use? Uninterruptible? Spinlock?
Aren't there big downsides to them also?
