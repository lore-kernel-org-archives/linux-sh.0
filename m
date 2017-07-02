From: Rob Landley <rob@landley.net>
Date: Sun, 02 Jul 2017 07:31:23 +0000
Subject: Reverting "sh: Remove implicit sign extension from assembler immediates"?
Message-Id: <390a2c33-844c-85c0-6b87-c8e5854a7061@landley.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Is reverting commit fea966f75642 still a good idea? Last I checked that
breaks old binutils versions and accomplishes nothing else...

Rob

