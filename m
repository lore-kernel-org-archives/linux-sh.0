From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 14 Jan 2014 12:23:39 +0000
Subject: [RESEND] v2: clock_ops.c fixes
Message-Id: <1389702222-17260-1-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@lists.codethink.co.uk, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

A re-send of the clk_ops.c fixes for handling clocks with the
current renesas development branch. I am not sure if these need
to be applied to any stable kernel branches.

From v1:
- Fixed comments from Rafael Wysocki on checking of ret.

