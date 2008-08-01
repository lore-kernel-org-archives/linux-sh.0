From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 01 Aug 2008 22:12:22 +0000
Subject: Re: sh O= builds broken
Message-Id: <20080801221222.GA14125@uranus.ravnborg.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080801212728.GF19682@cs181140183.pp.htv.fi> <20080801215338.GC13448@linux-sh.org>
In-Reply-To: <20080801215338.GC13448@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>, Adrian Bunk <bunk@kernel.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Aug 02, 2008 at 06:53:38AM +0900, Paul Mundt wrote:
> > 
> Ok, so this is what I get for moving the auto-generated header outside of
> include/asm-sh.. it seemed like a good idea at the time.
Ups - I should have caught that when I reviewd your initial patch.
kbuild does on purpose not fiddle with the path in the inital
include specification.

	Sam
