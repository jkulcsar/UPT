

	#ifndef _LINEAR_H
	#define _LINEAR_H
	#endif

	#ifndef _DATATYPE_H
	#include "datatype.h"
	#endif

	#ifndef _TRAJECT_H
	#include "traject.h"
	#endif


	class	Linear : public Trajectory
	{
		protected:
			BOOL	m_ComputePosition( void );
			BOOL	m_ComputeSpeed( void );
			BOOL	m_ComputeAcceleration( void );
			float	m_ComputeTrajectoryTime( void );
			BOOL	m_ComputeLambda( void );

			float	RPos( float );
			float	RAcc( void  );
			float	RSpd( void  );


		public:

			Linear(  void ); 				// Constructor ...
			~Linear( void );				// Destructor  ...

	};
