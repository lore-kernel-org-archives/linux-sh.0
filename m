From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 12 Nov 2013 16:04:38 +0000
Subject: rcar-h2 du issue between du0 and du2
Message-Id: <52825196.1090102@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I am using the 3.4 renesas backport (0.5.1) and having issue with the
rcar_du driver with any du0 and du2 having seperate operating modes.

du2 seems to be picking up the data width of du0, so if du0 is at
1920x1080 and du2 at 800x600, du2 will show a display as if du2 data
was at a 1920 stride.

If both du0 and du2 are at 800x600 then both show the right display
data,

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
