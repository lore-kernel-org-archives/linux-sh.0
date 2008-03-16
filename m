From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Sun, 16 Mar 2008 16:27:23 +0000
Subject: [HP6xx] - Detection of 16MB / 32MB - Questions
Message-Id: <20080316172833.ce3dbc1d.Kristoffer.Ericson@Gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul,

Currently we have 2 different configs for 16MB vs 32MB kernels since we cannot 
use mem= as bootparam anymore. Was thinking to add some sort of detection code 
for this inside the arch file.
Basicly try to write a value and check if it is stored. Would this be possible and if so
is the arch/boards/hp6xx/setup.c a good place for that?

-- 
Kristoffer Ericson <Kristoffer.Ericson@Gmail.com>
