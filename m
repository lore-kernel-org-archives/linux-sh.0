From: Pavel Machek <pavel@ucw.cz>
Date: Thu, 02 Jun 2011 03:14:00 +0000
Subject: Re: [PATCH 2/3] PM / Hibernate: Remove arch_prepare_suspend()
Message-Id: <20110602031400.GA1565@ucw.cz>
List-Id: <linux-sh.vger.kernel.org>
References: <201105211408.28671.rjw@sisk.pl>
 <201105211410.34491.rjw@sisk.pl>
In-Reply-To: <201105211410.34491.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Frank Hofmann <frank.hofmann@tomtom.com>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Sat 2011-05-21 14:10:34, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> All architectures supporting hibernation define
> arch_prepare_suspend() as an empty function, so remove it.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
